import argparse

from core_data_modules.logging import Logger
from core_data_modules.traced_data.io import TracedDataJsonIO, TracedDataCSVIO

log = Logger(__name__)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="")

    parser.add_argument("original_s01_demog_path", metavar="original-s01-demog-path",
                        help="")
    parser.add_argument("latest_s01_demog_path", metavar="latest-s01-demog-path",
                        help="")
    parser.add_argument("individuals_csv_path", metavar="individuals-csv-path",
                        help="")

    args = parser.parse_args()

    original_s01_demog_path = args.original_s01_demog_path
    latest_s01_demog_path = args.latest_s01_demog_path
    individuals_csv_path = args.individuals_csv_path

    log.info(f"Reading the original demographics from {original_s01_demog_path}...")
    with open(original_s01_demog_path) as f:
        original_s01_demogs = TracedDataJsonIO.import_json_to_traced_data_iterable(f)
    log.info(f"Loaded {len(original_s01_demogs)} original demographics contacts")

    log.info(f"Reading the latest demographics from {latest_s01_demog_path}...")
    with open(latest_s01_demog_path) as f:
        latest_s01_demogs = TracedDataJsonIO.import_json_to_traced_data_iterable(f)
    log.info(f"Loaded {len(latest_s01_demogs)} latest demographics contacts")

    log.info(f"Reading the individuals csv from {individuals_csv_path}...")
    with open(individuals_csv_path) as f:
        individuals_csv = list(TracedDataCSVIO.import_csv_to_traced_data_iterable("test", f))
    log.info(f"Loaded {len(individuals_csv)} individuals")

    log.info("Determining the unique ids for each dataset...")
    uuids_original_s01_demogs = {td["avf_phone_id"] for td in original_s01_demogs}
    uuids_latest_s01_demogs = {td["avf_phone_id"] for td in latest_s01_demogs}
    uuids_individuals = {td["uid"] for td in individuals_csv}
    log.info(f"UUIDs in original s01 demogs: {len(uuids_original_s01_demogs)}")
    log.info(f"UUIDs in latest s01 demogs: {len(uuids_latest_s01_demogs)}")
    log.info(f"UUIDs in individuals csv: {len(uuids_individuals)}")

    log.info("Determining the number of UUIDs in the s01 demog and the individuals dataset but not in the "
             "latest s01 demogs")
    original_s01_demogs_in_individuals = uuids_original_s01_demogs.intersection(uuids_individuals)
    log.info(f"Number of UUIDs in the original s01 demogs dataset and in the individuals dataset: "
             f"{len(original_s01_demogs_in_individuals)}")
    original_s01_demogs_in_individuals_but_not_latest_s01_demogs = original_s01_demogs_in_individuals - uuids_latest_s01_demogs
    log.info(f"Number of UUIDS in the original s01 demogs dataset and in the individuals dataset, but not in "
             f"the latest s01 demogs dataset: {len(original_s01_demogs_in_individuals_but_not_latest_s01_demogs)}")
