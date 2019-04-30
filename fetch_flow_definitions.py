import argparse
import json

from core_data_modules.logging import Logger
from core_data_modules.util import TimeUtils
from rapid_pro_tools.rapid_pro_client import RapidProClient
from storage.google_cloud import google_cloud_utils

from src.lib import PipelineConfiguration

log = Logger(__name__)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Downloads the definitions for all the flows being used by this "
                                                 "project, and uploads them to a bucket.")

    parser.add_argument("google_cloud_credentials_file_path", metavar="google-cloud-credentials-file-path",
                        help="Path to a Google Cloud service account credentials file to use to access the "
                             "cloud storage bucket that the flow definitions will be uploaded to")
    parser.add_argument("pipeline_configuration_file_path", metavar="pipeline-configuration-file",
                        help="Path to the pipeline configuration json file")

    args = parser.parse_args()

    pipeline_configuration_file_path = args.pipeline_configuration_file_path
    google_cloud_credentials_file_path = args.google_cloud_credentials_file_path

    log.info("Loading the pipeline configuration file...")
    with open(pipeline_configuration_file_path) as f:
        pipeline_configuration = PipelineConfiguration.from_configuration_file(f)

    log.info("Downloading the Rapid Pro token file and initialising the Rapid Pro client...")
    rapid_pro_token = google_cloud_utils.download_blob_to_string(
        google_cloud_credentials_file_path, pipeline_configuration.rapid_pro_token_file_url).strip()
    rapid_pro = RapidProClient(pipeline_configuration.rapid_pro_domain, rapid_pro_token)

    flow_names = pipeline_configuration.activation_flow_names + pipeline_configuration.survey_flow_names

    log.info(f"Downloading the definitions and triggers for {len(flow_names)} flows and their dependencies "
             f"from Rapid Pro...")
    flow_ids = rapid_pro.get_flow_ids(flow_names)
    request_timestamp = TimeUtils.utc_now_as_iso_string()
    flow_definitions = rapid_pro.get_flow_definitions_for_flow_ids(flow_ids)
    log.debug(f"Downloaded {len(flow_definitions.flows)} flows and {len(flow_definitions.triggers)} triggers")

    log.info("Serializing the downloaded definitions...")
    flow_definitions_json = json.dumps(flow_definitions.serialize(), indent=2)

    log.info("Uploading the flow definitions to a bucket...")
    upload_url = f"{pipeline_configuration.flow_definitions_upload_url_prefix}{request_timestamp}.json"
    google_cloud_utils.upload_string_to_blob(google_cloud_credentials_file_path, upload_url, flow_definitions_json)
