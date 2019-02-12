import json

from core_data_modules.cleaners import somali, Codes
from core_data_modules.data_models import Scheme


class CodeSchemes(object):
    @staticmethod
    def _open_scheme(filename):
        with open(f"code_schemes/{filename}", "r") as f:
            firebase_map = json.load(f)
            return Scheme.from_firebase_map(firebase_map)

    S02E01_REASONS = _open_scheme("s02e01_reasons.json")

    OPERATOR = _open_scheme("operator.json")

    GENDER = _open_scheme("gender.json")
    MOGADISHU_SUB_DISTRICT = _open_scheme("mogadishu_sub_district.json")
    DISTRICT = _open_scheme("district.json")
    REGION = _open_scheme("region.json")
    STATE = _open_scheme("state.json")
    ZONE = _open_scheme("zone.json")
    AGE = _open_scheme("age.json")
    IDP_CAMP = _open_scheme("idp_camp.json")
    RECENTLY_DISPLACED = _open_scheme("recently_displaced.json")
    HH_LANGUAGE = _open_scheme("hh_language.json")

    REPEATED = _open_scheme("repeated.json")
    INVOLVED = _open_scheme("involved.json")

    # WS_CORRECT_DATASET = _open_scheme("ws_correct_dataset.json")


class CodingPlan(object):
    def __init__(self, raw_field, coded_field, coda_filename, cleaner=None, code_scheme=None, time_field=None,
                 run_id_field=None, icr_filename=None, analysis_file_key=None, id_field=None,
                 binary_code_scheme=None, binary_coded_field=None, binary_analysis_file_key=None):
        self.raw_field = raw_field
        self.coded_field = coded_field
        self.coda_filename = coda_filename
        self.icr_filename = icr_filename
        self.cleaner = cleaner
        self.code_scheme = code_scheme
        self.time_field = time_field
        self.run_id_field = run_id_field
        self.analysis_file_key = analysis_file_key
        self.binary_code_scheme = binary_code_scheme
        self.binary_coded_field = binary_coded_field
        self.binary_analysis_file_key = binary_analysis_file_key

        if id_field is None:
            id_field = "{}_id".format(self.raw_field)
        self.id_field = id_field


class PipelineConfiguration(object):
    DEV_MODE = False

    RQA_CODING_PLANS = [
        CodingPlan(raw_field="rqa_s02e01_raw",
                   coded_field="rqa_s02e01_coded",
                   time_field="sent_on",
                   coda_filename="s02e01.json",
                   icr_filename="s02e01.csv",
                   run_id_field="rqa_s02e01_run_id",
                   analysis_file_key="rqa_s02e01_",
                   cleaner=None,
                   code_scheme=CodeSchemes.S02E01_REASONS)
    ]

    @staticmethod
    def clean_age_with_range_filter(text):
        """
        Cleans age from the given `text`, setting to NC if the cleaned age is not in the range 10 <= age < 100.
        """
        age = somali.DemographicCleaner.clean_age(text)
        if type(age) == int and 10 <= age < 100:
            return str(age)
            # TODO: Once the cleaners are updated to not return Codes.NOT_CODED, this should be updated to still return
            #       NC in the case where age is an int but is out of range
        else:
            return Codes.NOT_CODED

    LOCATION_CODING_PLANS = [
        CodingPlan(raw_field="location_raw",
                   id_field="location_raw_id",
                   coded_field="location_coded",
                   time_field="location_time",
                   coda_filename="location.json",
                   analysis_file_key=None,
                   cleaner=None,
                   code_scheme=CodeSchemes.MOGADISHU_SUB_DISTRICT),

        CodingPlan(raw_field="location_raw",
                   id_field="location_raw_id",
                   coded_field="location_coded",
                   time_field="location_time",
                   coda_filename="location.json",
                   analysis_file_key="district",
                   cleaner=somali.DemographicCleaner.clean_somalia_district,
                   code_scheme=CodeSchemes.DISTRICT),

        CodingPlan(raw_field="location_raw",
                   id_field="location_raw_id",
                   coded_field="location_coded",
                   time_field="location_time",
                   coda_filename="location.json",
                   analysis_file_key="region",
                   cleaner=None,
                   code_scheme=CodeSchemes.REGION),

        CodingPlan(raw_field="location_raw",
                   id_field="location_raw_id",
                   coded_field="location_coded",
                   time_field="location_time",
                   coda_filename="location.json",
                   analysis_file_key="state",
                   cleaner=None,
                   code_scheme=CodeSchemes.STATE),

        CodingPlan(raw_field="location_raw",
                   id_field="location_raw_id",
                   coded_field="location_coded",
                   time_field="location_time",
                   coda_filename="location.json",
                   analysis_file_key="zone",
                   cleaner=None,
                   code_scheme=CodeSchemes.ZONE),
    ]

    SURVEY_CODING_PLANS = [
        CodingPlan(raw_field="gender_raw",
                   coded_field="gender_coded",
                   time_field="gender_time",
                   coda_filename="gender.json",
                   analysis_file_key="gender",
                   cleaner=somali.DemographicCleaner.clean_gender,
                   code_scheme=CodeSchemes.GENDER)
    ]
    SURVEY_CODING_PLANS.extend(LOCATION_CODING_PLANS)
    SURVEY_CODING_PLANS.extend([
        CodingPlan(raw_field="age_raw",
                   coded_field="age_coded",
                   time_field="age_time",
                   coda_filename="age.json",
                   analysis_file_key="age",
                   cleaner=lambda text: PipelineConfiguration.clean_age_with_range_filter(text),
                   code_scheme=CodeSchemes.AGE),

        CodingPlan(raw_field="idp_camp_raw",
                   coded_field="idp_camp_coded",
                   time_field="idp_camp_time",
                   coda_filename="idp_camp.json",
                   analysis_file_key="idp_camp",
                   cleaner=somali.DemographicCleaner.clean_yes_no,
                   code_scheme=CodeSchemes.IDP_CAMP),

        CodingPlan(raw_field="recently_displaced_raw",
                   coded_field="recently_displaced_coded",
                   time_field="recently_displaced_time",
                   coda_filename="recently_displaced.json",
                   analysis_file_key="recently_displaced",
                   cleaner=somali.DemographicCleaner.clean_yes_no,
                   code_scheme=CodeSchemes.RECENTLY_DISPLACED),

        CodingPlan(raw_field="hh_language_raw",
                   coded_field="hh_language_coded",
                   time_field="hh_language_time",
                   coda_filename="hh_language.json",
                   analysis_file_key="hh_language",
                   cleaner=None,
                   code_scheme=CodeSchemes.HH_LANGUAGE),

        CodingPlan(raw_field="repeated_raw",
                   coded_field="repeated_coded",
                   time_field="repeated_time",
                   coda_filename="repeated.json",
                   analysis_file_key="repeated",
                   cleaner=somali.DemographicCleaner.clean_yes_no,
                   code_scheme=CodeSchemes.REPEATED),

        CodingPlan(raw_field="involved_raw",
                   coded_field="involved_coded",
                   time_field="involved_time",
                   coda_filename="involved.json",
                   analysis_file_key="involved",
                   cleaner=somali.DemographicCleaner.clean_yes_no,
                   code_scheme=CodeSchemes.INVOLVED)
    ])
