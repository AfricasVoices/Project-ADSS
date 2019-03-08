import argparse
import json
import os
import subprocess
from urllib.parse import urlparse

from core_data_modules.traced_data.io import TracedDataJsonIO
from core_data_modules.util import PhoneNumberUuidTable, IOUtils
from google.cloud import storage
from rapid_pro_tools.rapid_pro_client import RapidProClient
from temba_client.v2 import Contact, Run

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Fetches all the raw data for this project from Rapid Pro. "
                                                 "This script must be run from its parent directory.")

    parser.add_argument("user", help="Identifier of the user launching this program")
    parser.add_argument("google_cloud_credentials_file_path", metavar="google-cloud-credentials-file-path",
                        help="Path to a Google Cloud service account credentials file to use to access the "
                             "credentials bucket")
    parser.add_argument("pipeline_configuration_file_path", metavar="pipeline-configuration-file",
                        help="Path to the pipeline configuration json file"),
    parser.add_argument("rapid_pro_tools_dir", metavar="rapid-pro-tools-dir",
                        help="Path to a directory to checkout the required version of RapidProTools to")
    parser.add_argument("root_data_dir", metavar="root-data-dir",
                        help="Path to the root of the project data directory")

    args = parser.parse_args()

    user = args.user
    pipeline_configuration_file_path = args.pipeline_configuration_file_path
    google_cloud_credentials_file_path = args.google_cloud_credentials_file_path
    rapid_pro_tools_dir = args.rapid_pro_tools_dir
    root_data_dir = os.path.abspath(args.root_data_dir)

    uuid_table_path = f"{root_data_dir}/UUIDs/phone_uuids.json"

    SHOWS = [
        "csap_s02e01_activation",
        "csap_s02e02_activation",
        "csap_s02e03_activation",
        "csap_s02e04_activation",
        "csap_s02e05_activation",
        "csap_s02e06_activation"
    ]

    SURVEYS = [
        "csap_demog",
        "csap_s02_demog"
        # TODO: Fetch evaluation flow when it is ready in Rapid Pro
    ]

    FLOWS = SHOWS + SURVEYS

    TEST_CONTACTS_PATH = os.path.abspath("./test_contact_rapid_pro_ids.json")

    # Read the settings from the configuration file
    with open(pipeline_configuration_file_path) as f:
        pipeline_config = json.load(f)

        rapid_pro_base_url = pipeline_config["RapidProBaseURL"]
        rapid_pro_token_file_url = pipeline_config["RapidProTokenFileURL"]

    # Download/checkout the appropriate version of RapidProTools
    exit_code = subprocess.call(["./checkout_rapid_pro_tools.sh", rapid_pro_tools_dir])
    assert exit_code == 0, f"./checkout_rapid_pro_tools.sh failed with exit_code {exit_code}"

    # Fetch the Rapid Pro Token from the Google Cloud Storage URL
    parsed_rapid_pro_token_file_url = urlparse(rapid_pro_token_file_url)
    assert parsed_rapid_pro_token_file_url.scheme == "gs", "RapidProTokenFileURL needs to be a gs URL " \
                                                           "(i.e. of the form gs://bucket-name/file)"
    bucket_name = parsed_rapid_pro_token_file_url.netloc
    blob_name = parsed_rapid_pro_token_file_url.path.lstrip("/")

    print(f"Downloading Rapid Pro token from file '{blob_name}' in bucket '{bucket_name}'...")
    storage_client = storage.Client.from_service_account_json(google_cloud_credentials_file_path)
    credentials_bucket = storage_client.bucket(bucket_name)
    credentials_file = credentials_bucket.blob(blob_name)
    rapid_pro_token = credentials_file.download_as_string().strip().decode("utf-8")
    print("Downloaded Rapid Pro token.")

    with open(uuid_table_path) as f:
        phone_number_uuid_table = PhoneNumberUuidTable.load(f)

    with open(TEST_CONTACTS_PATH) as f:
        test_contacts = json.load(f)

    IOUtils.ensure_dirs_exist(f"{root_data_dir}/Raw Data")

    rapid_pro = RapidProClient(rapid_pro_base_url, rapid_pro_token)

    # Load the previous export of contacts if it exists, otherwise fetch all contacts from Rapid Pro.
    raw_contacts_path = f"{root_data_dir}/Raw Data/contacts_raw.json"
    contacts_log_path = f"{root_data_dir}/Raw Data/contacts_log.jsonl"
    try:
        print(f"Loading raw contacts from file '{raw_contacts_path}'...")
        with open(raw_contacts_path) as f:
            raw_contacts = [Contact.deserialize(contact_json) for contact_json in json.load(f)]
        print(f"Loaded {len(raw_contacts)} contacts")
    except FileNotFoundError:
        print(f"File '{raw_contacts_path}' not found, will fetch all contacts from the Rapid Pro server")
        with open(contacts_log_path, "a") as f:
            raw_contacts = rapid_pro.get_raw_contacts(raw_export_log=f)

    # Download all the runs for each of the radio shows
    for flow in FLOWS:
        runs_log_path = f"{root_data_dir}/Raw Data/{flow}_log.jsonl"
        raw_runs_path = f"{root_data_dir}/Raw Data/{flow}_raw.json"
        traced_runs_output_path = f"{root_data_dir}/Raw Data/{flow}.json"
        print(f"Exporting show '{flow}' to '{traced_runs_output_path}'...")

        flow_id = rapid_pro.get_flow_id(flow)

        # Load the previous export of runs for this flow, and update them with the newest runs.
        # If there is no previous export for this flow, fetch all the runs from Rapid Pro.
        with open(runs_log_path, "a") as raw_export_log_file:
            try:
                print(f"Loading raw runs from file '{raw_runs_path}'...")
                with open(raw_runs_path) as f:
                    raw_runs = [Run.deserialize(run_json) for run_json in json.load(f)]
                print(f"Loaded {len(raw_runs)} runs")
                raw_runs = rapid_pro.update_raw_runs_with_latest_modified(
                    flow_id, raw_runs, raw_export_log=raw_export_log_file)
            except FileNotFoundError:
                print(f"File '{raw_runs_path}' not found, will fetch all runs from the Rapid Pro server for flow '{flow}'")
                raw_runs = rapid_pro.get_raw_runs_for_flow_id(flow_id, raw_export_log=raw_export_log_file)

        # Fetch the latest contacts from Rapid Pro.
        with open(contacts_log_path, "a") as f:
            raw_contacts = rapid_pro.update_raw_contacts_with_latest_modified(raw_contacts, raw_export_log=f)

        # Convert the runs to TracedData.
        traced_runs = rapid_pro.convert_runs_to_traced_data(
            user, raw_runs, raw_contacts, phone_number_uuid_table, test_contacts)
        
        # Save the latest set of raw runs to disk.
        with open(raw_runs_path, "w") as f:
            json.dump([run.serialize() for run in raw_runs], f)

        # Save the updated phone number <-> uuid table to disk.
        with open(uuid_table_path, "w") as f:
            phone_number_uuid_table.dump(f)

        # Save the traced runs to disk..
        IOUtils.ensure_dirs_exist_for_file(traced_runs_output_path)
        with open(traced_runs_output_path, "w") as f:
            TracedDataJsonIO.export_traced_data_iterable_to_json(traced_runs, f, pretty_print=True)

    # Save the latest raw contacts to disk.
    with open(raw_contacts_path, "w") as f:
        print(f"Saving {len(raw_contacts)} raw contacts to file '{raw_contacts_path}'...")
        json.dump([contact.serialize() for contact in raw_contacts], f)
        print(f"Saved {len(raw_contacts)} contacts")
