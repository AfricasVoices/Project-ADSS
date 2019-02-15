import time

from core_data_modules.cleaners import Codes
from core_data_modules.traced_data import Metadata
from dateutil.parser import isoparse

from src.lib import PipelineConfiguration


class Channels(object):
    SMS_AD_KEY = "sms_ad"
    RADIO_PROMO_KEY = "radio_promo"
    RADIO_SHOW_KEY = "radio_show"
    NON_LOGICAL_KEY = "non_logical_time"
    S02E01_KEY = "radio_participation_s02e01"
    S02E02_KEY = "radio_participation_s02e02"
    S02E03_KEY = "radio_participation_s02e03"
    S02E04_KEY = "radio_participation_s02e04"
    S02E05_KEY = "radio_participation_s02e05"
    S02E06_KEY = "radio_participation_s02e06"

    # Time ranges expressed in format (start_of_range_inclusive, end_of_range_exclusive)
    SMS_AD_RANGES = [

    ]

    RADIO_PROMO_RANGES = [

    ]

    RADIO_SHOW_RANGES = [

    ]

    S02E01_RANGES = [
        ("2019-02-17T00:00:00+03:00", "2019-02-23T24:00:00+03:00")
    ]

    S02E02_RANGES = [
        ("2019-02-24T00:00:00+03:00", "2019-03-02T24:00:00+03:00")
    ]

    S02E03_RANGES = [
        ("2019-03-03T00:00:00+03:00", "2019-03-09T24:00:00+03:00")
    ]

    S02E04_RANGES = [
        ("2019-03-10T00:00:00+03:00", "2019-03-16T24:00:00+03:00")
    ]

    S02E05_RANGES = [
        ("2019-03-17T00:00:00+03:00", "2019-03-23T24:00:00+03:00")
    ]

    S02E06_RANGES = [
        ("2019-03-24T00:00:00+03:00", "2019-03-30T24:00:00+03:00")
    ]

    CHANNEL_RANGES = {
        SMS_AD_KEY: SMS_AD_RANGES,
        RADIO_PROMO_KEY: RADIO_PROMO_RANGES,
        RADIO_SHOW_KEY: RADIO_SHOW_RANGES
    }

    SHOW_RANGES = {
        S02E01_KEY: S02E01_RANGES,
        S02E02_KEY: S02E02_RANGES,
        S02E03_KEY: S02E03_RANGES,
        S02E04_KEY: S02E04_RANGES,
        S02E05_KEY: S02E05_RANGES,
        S02E06_KEY: S02E06_RANGES,
    }

    @staticmethod
    def timestamp_is_in_ranges(timestamp, ranges):
        for range in ranges:
            if isoparse(range[0]) <= timestamp < isoparse(range[1]):
                return True
        return False

    @classmethod
    def set_channel_keys(cls, user, data, time_key):
        for td in data:
            timestamp = isoparse(td[time_key])

            channel_dict = dict()

            # Set channel ranges
            time_range_matches = 0
            for key, ranges in cls.CHANNEL_RANGES.items():
                if cls.timestamp_is_in_ranges(timestamp, ranges):
                    time_range_matches += 1
                    channel_dict[key] = Codes.TRUE
                else:
                    channel_dict[key] = Codes.FALSE

            # Set time as NON_LOGICAL if it doesn't fall in range of the **sms ad/radio promo/radio_show**
            if time_range_matches == 0:
                # Assert in range of project
                assert PipelineConfiguration.PROJECT_START_DATE <= timestamp < PipelineConfiguration.PROJECT_END_DATE, \
                    f"Timestamp {td[time_key]} out of range of project"
                channel_dict[cls.NON_LOGICAL_KEY] = Codes.TRUE
            else:
                assert time_range_matches == 1, f"Time '{td[time_key]}' matches multiple time ranges"
                channel_dict[cls.NON_LOGICAL_KEY] = Codes.FALSE

            # Set show ranges
            for key, ranges in cls.SHOW_RANGES.items():
                if cls.timestamp_is_in_ranges(timestamp, ranges):
                    channel_dict[key] = Codes.TRUE
                else:
                    channel_dict[key] = Codes.FALSE

            td.append_data(channel_dict, Metadata(user, Metadata.get_call_location(), time.time()))
