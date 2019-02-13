from core_data_modules.traced_data import Metadata
from core_data_modules.util import TimeUtils


class TranslateRapidProKeys(object):
    # TODO: Move the constants in this file to configuration json
    RAPID_PRO_KEY_MAP = [
        # List of (new_key, old_key)
        ("uid", "avf_phone_id"),

        ("rqa_s02e01_run_id", "Rqa_S02E01 (Run ID) - csap_s02e01_activation"),
        ("rqa_s02e02_run_id", "Rqa_S02E02 (Run ID) - csap_s02e02_activation"),
        ("rqa_s02e03_run_id", "Rqa_S02E03 (Run ID) - csap_s02e03_activation"),
        ("rqa_s02e04_run_id", "Rqa_S02E04 (Run ID) - csap_s02e04_activation"),
        ("rqa_s02e05_run_id", "Rqa_S02E05 (Run ID) - csap_s02e05_activation"),
        ("rqa_s02e06_run_id", "Rqa_S02E06 (Run ID) - csap_s02e06_activation"),

        ("sent_on", "Rqa_S02E01 (Time) - csap_s02e01_activation"),
        ("sent_on", "Rqa_S02E02 (Time) - csap_s02e02_activation"),
        ("sent_on", "Rqa_S02E03 (Time) - csap_s02e03_activation"),
        ("sent_on", "Rqa_S02E04 (Time) - csap_s02e04_activation"),
        ("sent_on", "Rqa_S02E05 (Time) - csap_s02e05_activation"),
        ("sent_on", "Rqa_S02E06 (Time) - csap_s02e06_activation"),

        ("gender_raw", "Gender (Value) - csap_demog"),
        ("gender_time", "Gender (Time) - csap_demog"),
        ("location_raw", "Mog_Sub_District (Value) - csap_demog"),
        ("location_time", "Mog_Sub_District (Time) - csap_demog"),
        ("age_raw", "Age (Value) - csap_demog"),
        ("age_time", "Age (Time) - csap_demog"),
        ("idp_camp_raw", "Idp_Camp (Value) - csap_demog"),
        ("idp_camp_time", "Idp_Camp (Time) - csap_demog"),
        ("recently_displaced_raw", "Recently_Displaced (Value) - csap_demog"),
        ("recently_displaced_time", "Recently_Displaced (Time) - csap_demog"),
        ("hh_language_raw", "Hh_Language (Value) - csap_demog"),
        ("hh_language_time", "Hh_Language (Time) - csap_demog"),

        ("gender_raw", "Gender (Value) - csap_s02_demog"),
        ("gender_time", "Gender (Time) - csap_s02_demog"),
        ("location_raw", "District (Value) - csap_s02_demog"),
        ("location_time", "District (Time) - csap_s02_demog"),
        ("age_raw", "Age (Value) - csap_s02_demog"),
        ("age_time", "Age (Time) - csap_s02_demog"),
        ("idp_camp_raw", "Idp_Camp (Value) - csap_s02_demog"),
        ("idp_camp_time", "Idp_Camp (Time) - csap_s02_demog"),
        ("recently_displaced_raw", "Recently_Displaced (Value) - csap_s02_demog"),
        ("recently_displaced_time", "Recently_Displaced (Time) - csap_s02_demog"),
        ("hh_language_raw", "Hh_Language (Value) - csap_s02_demog"),
        ("hh_language_time", "Hh_Language (Time) - csap_s02_demog"),

        # ("repeated_raw", "Repeated (Value) - csap_evaluation"),
        # ("repeated_time", "Repeated (Time) - csap_evaluation"),
        # ("involved_raw", "Involved (Value) - csap_evaluation"),
        # ("involved_time", "Involved (Time) - csap_evaluation")
    ]

    SHOW_ID_MAP = {
        "Rqa_S02E01 (Value) - csap_s02e01_activation": 1,
        "Rqa_S02E02 (Value) - csap_s02e02_activation": 2,
        "Rqa_S02E03 (Value) - csap_s02e03_activation": 3,
        "Rqa_S02E04 (Value) - csap_s02e04_activation": 4,
        "Rqa_S02E05 (Value) - csap_s02e05_activation": 5,
        "Rqa_S02E06 (Value) - csap_s02e06_activation": 6
    }

    RAW_ID_MAP = {
        1: "rqa_s02e01_raw",
        2: "rqa_s02e02_raw",
        3: "rqa_s02e03_raw",
        4: "rqa_s02e04_raw",
        5: "rqa_s02e05_raw",
        6: "rqa_s02e06_raw"
    }

    @classmethod
    def set_show_ids(cls, user, data, show_id_map):
        """
        Sets a show_id for each message, using the presence of Rapid Pro value keys to determine which show each message
        belongs to.

        :param user: Identifier of the user running this program, for TracedData Metadata.
        :type user: str
        :param data: TracedData objects to set the show ids of.
        :type data: iterable of TracedData
        :param show_id_map: Dictionary of Rapid Pro value key to show id.
        :type show_id_map: dict of str -> int
        """
        for td in data:
            show_dict = dict()

            for message_key, show_id in show_id_map.items():
                if message_key in td:
                    assert "rqa_message" not in show_dict
                    show_dict["rqa_message"] = td[message_key]
                    show_dict["show_id"] = show_id

            td.append_data(show_dict, Metadata(user, Metadata.get_call_location(), TimeUtils.utc_now_as_iso_string()))

    @classmethod
    def remap_radio_shows(cls, user, data, coda_input_dir):
        """
        Remaps radio shows which were in the wrong flow, and therefore have the wrong key/values set, to have the
        key/values they would have had if they had been received by the correct flow.

        :param user: Identifier of the user running this program, for TracedData Metadata.
        :type user: str
        :param data: TracedData objects to move the radio show messages in.
        :type data: iterable of TracedData
        :param coda_input_dir: Directory to read coded coda files from.
        :type coda_input_dir: str
        """
        # No implementation needed yet, because no flow is yet to go wrong in production.
        pass

    @classmethod
    def remap_key_names(cls, user, data, key_map):
        """
        Remaps key names.
        
        :param user: Identifier of the user running this program, for TracedData Metadata.
        :type user: str
        :param data: TracedData objects to remap the key names of.
        :type data: iterable of TracedData
        :param key_map: Iterable of (new_key, old_key).
        :type key_map: iterable of (str, str)
        """
        for td in data:
            remapped = dict()
               
            for new_key, old_key in key_map:
                if old_key in td and new_key not in td:
                    remapped[new_key] = td[old_key]

            td.append_data(remapped, Metadata(user, Metadata.get_call_location(), TimeUtils.utc_now_as_iso_string()))

    @classmethod
    def set_rqa_raw_keys_from_show_ids(cls, user, data, raw_id_map):
        """
        Despite the earlier phases of this pipeline stage using a common 'rqa_message' field and then a 'show_id'
        field to identify which radio show a message belonged to, the rest of the pipeline still uses the presence
        of a raw field for each show to determine which show a message belongs to. This function translates from
        the new 'show_id' method back to the old 'raw field presence` method.
        
        TODO: Update the rest of the pipeline to use show_ids, and/or perform remapping before combining the datasets.

        :param user: Identifier of the user running this program, for TracedData Metadata.
        :type user: str
        :param data: TracedData objects to set raw radio show message fields for.
        :type data: iterable of TracedData
        :param raw_id_map: Dictionary of show id to the rqa message key to assign each td[rqa_message} to.
        :type raw_id_map: dict of int -> str
        """
        for td in data:
            for show_id, message_key in raw_id_map.items():
                if "rqa_message" in td and td.get("show_id") == show_id:
                    td.append_data({message_key: td["rqa_message"]},
                                   Metadata(user, Metadata.get_call_location(), TimeUtils.utc_now_as_iso_string()))

    @classmethod
    def translate_rapid_pro_keys(cls, user, data, coda_input_dir):
        """
        Remaps the keys of rqa messages in the wrong flow into the correct one, and remaps all Rapid Pro keys to
        more usable keys that can be used by the rest of the pipeline.
        
        TODO: Break this function such that the show remapping phase happens in one class, and the Rapid Pro remapping
              in another?
        """
        # Set a show id field for each message, using the presence of Rapid Pro value keys in the TracedData.
        # Show ids are necessary in order to be able to remap radio shows and key names separately (because data
        # can't be 'deleted' from TracedData).
        cls.set_show_ids(user, data, cls.SHOW_ID_MAP)

        # Move rqa messages which ended up in the wrong flow to the correct one.
        cls.remap_radio_shows(user, data, coda_input_dir)

        # Remap the keys used by Rapid Pro to more usable key names that will be used by the rest of the pipeline.
        cls.remap_key_names(user, data, cls.RAPID_PRO_KEY_MAP)

        # Convert from the new show id format to the raw field format still used by the rest of the pipeline.
        cls.set_rqa_raw_keys_from_show_ids(user, data, cls.RAW_ID_MAP)

        return data
