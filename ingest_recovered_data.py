import argparse
import csv
from datetime import datetime

import pytz
from core_data_modules.logging import Logger
from core_data_modules.traced_data import Metadata, TracedData
from core_data_modules.traced_data.io import TracedDataJsonIO
from core_data_modules.util import PhoneNumberUuidTable, TimeUtils, SHAUtils

log = Logger(__name__)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Converts messages in the recovery CSV format to TracedData "
                                                 "which can be processed by the pipeline")

    parser.add_argument("user", help="Identifier of the user launching this program")
    parser.add_argument("recovered_csv_input_path", metavar="recovered-csv-input-path",
                        help="Path to a CSV file containing the recovered data")
    parser.add_argument("phone_number_uuid_table_path", metavar="phone-number-uuid-table-path",
                        help="Path to the phone number <-> uuid table")
    parser.add_argument("traced_data_output_path", metavar="traced-data-output-path",
                        help="Path to a JSON file to write the serialized data output to")

    args = parser.parse_args()

    user = args.user
    recovered_csv_input_path = args.recovered_csv_input_path
    phone_number_uuid_table_path = args.phone_number_uuid_table_path
    dataset_id = args.dataset_id
    traced_data_output_path = args.traced_data_output_path

    log.info(f"Reading recovered data from '{recovered_csv_input_path}'...")
    with open(recovered_csv_input_path, "r") as f:
        raw_data = list(csv.DictReader(f))
    log.info(f"Read {len(raw_data)} recovered messages")

    log.info(f"Loading the phone number <-> uuid table from '{phone_number_uuid_table_path}'...")
    with open(phone_number_uuid_table_path) as f:
        phone_number_uuid_table = PhoneNumberUuidTable.load(f)
    log.info(f"Loaded {len(phone_number_uuid_table.numbers())} phone number <-> uuid mappings")

    log.info("Converting the recovered messages to TracedData...")
    data = []
    for i, row in enumerate(raw_data):
        raw_date = row["Received On"]
        parsed_raw_date = datetime.strptime(raw_date, "%m/%d/%y %H:%M")
        localized_date = pytz.timezone("Africa/Mogadishu").localize(parsed_raw_date)

        d = {
            "avf_phone_id": phone_number_uuid_table.add_phone(row["Mobile No"]),
            "message": row["Message Content"],
            "received_on": localized_date.isoformat(),
            "run_id": SHAUtils.sha_dict(row)
        }

        data.append(TracedData(d, Metadata(user, Metadata.get_call_location(), TimeUtils.utc_now_as_iso_string())))
    log.info("Converted the recovered messages to TracedData...")

    log.info(f"Updating the phone number <-> uuid table at '{phone_number_uuid_table_path}' "
             f"with {len(phone_number_uuid_table.numbers())} phone number <-> uuid mappings...")
    with open(phone_number_uuid_table_path, "w") as f:
        phone_number_uuid_table.dump(f)
    log.info(f"Updated the phone number <-> uuid table")

    log.info(f"Exporting {len(data)} TracedData items to {traced_data_output_path}...")
    with open(traced_data_output_path, "w") as f:
        TracedDataJsonIO.export_traced_data_iterable_to_json(data, f, pretty_print=True)
    log.info(f"Exported TracedData")
