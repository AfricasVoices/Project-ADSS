import argparse
import json
from urllib.parse import urlparse

from core_data_modules.logging import Logger
from core_data_modules.traced_data.io import TracedDataJsonIO
from core_data_modules.util import PhoneNumberUuidTable, IOUtils
from google.cloud import storage
from rapid_pro_tools.rapid_pro_client import RapidProClient
from temba_client.v2 import Contact, Run

from src.lib import PipelineConfiguration

Logger.set_project_name("ADSS")
log = Logger(__name__)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Fetches all the raw data for this project from Rapid Pro. "
                                                 "This script must be run from its parent directory.")

    parser.add_argument("user", help="Identifier of the user launching this program")
    parser.add_argument("google_cloud_credentials_file_path", metavar="google-cloud-credentials-file-path",
                        help="Path to a Google Cloud service account credentials file to use to access the "
                             "credentials bucket")
    parser.add_argument("pipeline_configuration_file_path", metavar="pipeline-configuration-file",
                        help="Path to the pipeline configuration json file"),
    parser.add_argument("phone_number_uuid_table_path", metavar="phone-number-uuid-table-path",
                        help="Path to a ")
    parser.add_argument("raw_data_dir", metavar="raw-data-dir",
                        help="Path to a directory to save the raw data to")

    args = parser.parse_args()

    user = args.user
    pipeline_configuration_file_path = args.pipeline_configuration_file_path
    google_cloud_credentials_file_path = args.google_cloud_credentials_file_path
    phone_number_uuid_table_path = args.phone_number_uuid_table_path
    raw_data_dir = args.raw_data_dir

    # Read the settings from the configuration file
    log.info("Loading Pipeline Configuration File...")
    with open(pipeline_configuration_file_path) as f:
        pipeline_configuration = PipelineConfiguration.from_configuration_file(f)

    # Fetch the Rapid Pro Token from the Google Cloud Storage URL
    parsed_rapid_pro_token_file_url = urlparse(pipeline_configuration.rapid_pro_token_file_url)
    assert parsed_rapid_pro_token_file_url.scheme == "gs", "RapidProTokenFileURL needs to be a gs URL " \
                                                           "(i.e. of the form gs://bucket-name/file)"
    bucket_name = parsed_rapid_pro_token_file_url.netloc
    blob_name = parsed_rapid_pro_token_file_url.path.lstrip("/")

    log.info(f"Downloading Rapid Pro token from file '{blob_name}' in bucket '{bucket_name}'...")
    storage_client = storage.Client.from_service_account_json(google_cloud_credentials_file_path)
    credentials_bucket = storage_client.bucket(bucket_name)
    credentials_blob = credentials_bucket.blob(blob_name)
    rapid_pro_token = credentials_blob.download_as_string().strip().decode("utf-8")
    log.info("Downloaded Rapid Pro token.")

    log.info("Loading Phone Number <-> UUID Table...")
    with open(phone_number_uuid_table_path) as f:
        phone_number_uuid_table = PhoneNumberUuidTable.load(f)
    log.info(f"Loaded {len(phone_number_uuid_table.numbers())} phone number <-> uuid mappings")

    rapid_pro = RapidProClient(pipeline_configuration.rapid_pro_domain, rapid_pro_token)

    # Load the previous export of contacts if it exists, otherwise fetch all contacts from Rapid Pro.
    raw_contacts_path = f"{raw_data_dir}/contacts_raw.json"
    contacts_log_path = f"{raw_data_dir}/contacts_log.jsonl"
    try:
        log.info(f"Loading raw contacts from file '{raw_contacts_path}'...")
        with open(raw_contacts_path) as raw_contacts_file:
            raw_contacts = [Contact.deserialize(contact_json) for contact_json in json.load(raw_contacts_file)]
        log.info(f"Loaded {len(raw_contacts)} contacts")
    except FileNotFoundError:
        log.info(f"File '{raw_contacts_path}' not found, will fetch all contacts from the Rapid Pro server")
        with open(contacts_log_path, "a") as contacts_log_file:
            raw_contacts = rapid_pro.get_raw_contacts(raw_export_log_file=contacts_log_file)

    # Download all the runs for each of the radio shows
    for flow in pipeline_configuration.activation_flow_names + pipeline_configuration.survey_flow_names:
        runs_log_path = f"{raw_data_dir}/{flow}_log.jsonl"
        raw_runs_path = f"{raw_data_dir}/{flow}_raw.json"
        traced_runs_output_path = f"{raw_data_dir}/{flow}.json"
        log.info(f"Exporting flow '{flow}' to '{traced_runs_output_path}'...")

        flow_id = rapid_pro.get_flow_id(flow)

        # Load the previous export of runs for this flow, and update them with the newest runs.
        # If there is no previous export for this flow, fetch all the runs from Rapid Pro.
        with open(runs_log_path, "a") as raw_runs_log_file:
            try:
                log.info(f"Loading raw runs from file '{raw_runs_path}'...")
                with open(raw_runs_path) as raw_runs_file:
                    raw_runs = [Run.deserialize(run_json) for run_json in json.load(raw_runs_file)]
                log.info(f"Loaded {len(raw_runs)} runs")
                raw_runs = rapid_pro.update_raw_runs_with_latest_modified(
                    flow_id, raw_runs, raw_export_log_file=raw_runs_log_file)
            except FileNotFoundError:
                log.info(f"File '{raw_runs_path}' not found, will fetch all runs from the Rapid Pro server for flow '{flow}'")
                raw_runs = rapid_pro.get_raw_runs_for_flow_id(flow_id, raw_export_log_file=raw_runs_log_file)

        # Fetch the latest contacts from Rapid Pro.
        with open(contacts_log_path, "a") as raw_contacts_log_file:
            raw_contacts = rapid_pro.update_raw_contacts_with_latest_modified(raw_contacts,
                                                                              raw_export_log_file=raw_contacts_log_file)

        # Convert the runs to TracedData.
        traced_runs = rapid_pro.convert_runs_to_traced_data(
            user, raw_runs, raw_contacts, phone_number_uuid_table, pipeline_configuration.rapid_pro_test_contact_uuids)

        log.info(f"Saving {len(raw_runs)} raw runs to {raw_runs_path}...")
        with open(raw_runs_path, "w") as raw_runs_file:
            json.dump([run.serialize() for run in raw_runs], raw_runs_file)
        log.info(f"Saved {len(raw_runs)} raw runs")

        log.info(f"Saving the update phone number <-> uuid table to {phone_number_uuid_table_path}...")
        with open(phone_number_uuid_table_path, "w") as f:
            phone_number_uuid_table.dump(f)
        log.info(f"Saved the phone number <-> uuid table ({len(phone_number_uuid_table.numbers())} mappings)")

        log.info(f"Saving {len(traced_runs)} traced runs to {traced_runs_output_path}...")
        IOUtils.ensure_dirs_exist_for_file(traced_runs_output_path)
        with open(traced_runs_output_path, "w") as traced_runs_output_file:
            TracedDataJsonIO.export_traced_data_iterable_to_json(traced_runs, traced_runs_output_file, pretty_print=True)
        log.info(f"Saved {len(traced_runs)} traced runs")

    log.info(f"Saving {len(raw_contacts)} raw contacts to file '{raw_contacts_path}'...")
    with open(raw_contacts_path, "w") as raw_contacts_file:
        json.dump([contact.serialize() for contact in raw_contacts], raw_contacts_file)
    log.info(f"Saved {len(raw_contacts)} contacts")
