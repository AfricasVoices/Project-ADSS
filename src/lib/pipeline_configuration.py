import json
from urllib.parse import urlparse

from core_data_modules.cleaners import somali, Codes
from core_data_modules.data_models import Scheme, validators
from dateutil.parser import isoparse


def _open_scheme(filename):
    with open(f"code_schemes/{filename}", "r") as f:
        firebase_map = json.load(f)
        return Scheme.from_firebase_map(firebase_map)


class CodeSchemes(object):
    S02E01_REASONS = _open_scheme("s02e01_reasons.json")
    S02E02_REASONS = _open_scheme("s02e02_reasons.json")
    S02E03_REASONS = _open_scheme("s02e03_reasons.json")
    S02E04_REASONS = _open_scheme("s02e04_reasons.json")
    S02E04_YES_NO_AMB = _open_scheme("s02e04_yes_no_amb.json")
    S02E05_REASONS = _open_scheme("s02e05_reasons.json")
    S02E05_YES_NO_AMB = _open_scheme("s02e05_yes_no_amb.json")
    S02E06_REASONS = _open_scheme("s02e06_reasons.json")
    S02E06_YES_NO_AMB = _open_scheme("s02e06_yes_no_amb.json")

    SOMALIA_OPERATOR = _open_scheme("somalia_operator.json")

    GENDER = _open_scheme("gender.json")
    MOGADISHU_SUB_DISTRICT = _open_scheme("mogadishu_sub_district.json")
    SOMALIA_DISTRICT = _open_scheme("somalia_district.json")
    SOMALIA_REGION = _open_scheme("somalia_region.json")
    SOMALIA_STATE = _open_scheme("somalia_state.json")
    SOMALIA_ZONE = _open_scheme("somalia_zone.json")
    AGE = _open_scheme("age.json")
    IDP_CAMP = _open_scheme("idp_camp.json")
    RECENTLY_DISPLACED = _open_scheme("recently_displaced.json")
    HOUSEHOLD_LANGUAGE = _open_scheme("household_language.json")

    POSITIVE_IMPACT = _open_scheme("positive_impact.json")
    USEFUL_INFO = _open_scheme("useful_info.json")
    INVOLVEMENT = _open_scheme("involvement.json")

    WS_CORRECT_DATASET = _open_scheme("ws_correct_dataset.json")


class CodingPlan(object):
    def __init__(self, raw_field, coded_field, coda_filename, cleaner=None, code_scheme=None, time_field=None,
                 run_id_field=None, icr_filename=None, analysis_file_key=None, id_field=None, ws_code=None,
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
        self.ws_code = ws_code
        self.binary_code_scheme = binary_code_scheme
        self.binary_coded_field = binary_coded_field
        self.binary_analysis_file_key = binary_analysis_file_key

        if id_field is None:
            id_field = "{}_id".format(self.raw_field)
        self.id_field = id_field


class PipelineConfiguration(object):
    RQA_CODING_PLANS = [
        CodingPlan(raw_field="rqa_s02e01_raw",
                   coded_field="rqa_s02e01_coded",
                   time_field="sent_on",
                   coda_filename="s02e01.json",
                   icr_filename="s02e01.csv",
                   run_id_field="rqa_s02e01_run_id",
                   analysis_file_key="rqa_s02e01_",
                   ws_code=CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("s02e01"),
                   cleaner=None,
                   code_scheme=CodeSchemes.S02E01_REASONS),

        CodingPlan(raw_field="rqa_s02e02_raw",
                   coded_field="rqa_s02e02_coded",
                   time_field="sent_on",
                   coda_filename="s02e02.json",
                   icr_filename="s02e02.csv",
                   run_id_field="rqa_s02e02_run_id",
                   analysis_file_key="rqa_s02e02_",
                   ws_code=CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("s02e02"),
                   cleaner=None,
                   code_scheme=CodeSchemes.S02E02_REASONS),

        CodingPlan(raw_field="rqa_s02e03_raw",
                   coded_field="rqa_s02e03_coded",
                   time_field="sent_on",
                   coda_filename="s02e03.json",
                   icr_filename="s02e03.csv",
                   run_id_field="rqa_s02e03_run_id",
                   analysis_file_key="rqa_s02e03_",
                   ws_code=CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("s02e03"),
                   cleaner=None,
                   code_scheme=CodeSchemes.S02E03_REASONS),

        CodingPlan(raw_field="rqa_s02e04_raw",
                   coded_field="rqa_s02e04_coded",
                   time_field="sent_on",
                   coda_filename="s02e04.json",
                   icr_filename="s02e04.csv",
                   run_id_field="rqa_s02e04_run_id",
                   analysis_file_key="rqa_s02e04_",
                   ws_code=CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("s02e04"),
                   cleaner=None,
                   code_scheme=CodeSchemes.S02E04_REASONS,
                   binary_code_scheme=CodeSchemes.S02E04_YES_NO_AMB,
                   binary_coded_field="rqa_s02e04_yes_no_amb_coded",
                   binary_analysis_file_key="rqa_s02e04_yes_no_amb"),

        CodingPlan(raw_field="rqa_s02e05_raw",
                   coded_field="rqa_s02e05_coded",
                   time_field="sent_on",
                   coda_filename="s02e05.json",
                   icr_filename="s02e05.csv",
                   run_id_field="rqa_s02e05_run_id",
                   analysis_file_key="rqa_s02e05_",
                   ws_code=CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("s02e05"),
                   cleaner=None,
                   code_scheme=CodeSchemes.S02E05_REASONS,
                   binary_code_scheme=CodeSchemes.S02E05_YES_NO_AMB,
                   binary_coded_field="rqa_s02e05_yes_no_amb_coded",
                   binary_analysis_file_key="rqa_s02e05_yes_no_amb"),

        CodingPlan(raw_field="rqa_s02e06_raw",
                   coded_field="rqa_s02e06_coded",
                   time_field="sent_on",
                   coda_filename="s02e06.json",
                   icr_filename="s02e06.csv",
                   run_id_field="rqa_s02e06_run_id",
                   analysis_file_key="rqa_s02e06_",
                   ws_code=CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("s02e06"),
                   cleaner=None,
                   code_scheme=CodeSchemes.S02E06_REASONS,
                   binary_code_scheme=CodeSchemes.S02E06_YES_NO_AMB,
                   binary_coded_field="rqa_s02e06_yes_no_amb_coded",
                   binary_analysis_file_key="rqa_s02e06_yes_no_amb")
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
                   coded_field="mogadishu_sub_district_coded",
                   time_field="location_time",
                   coda_filename="location.json",
                   analysis_file_key=None,
                   ws_code=CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("location"),
                   cleaner=None,
                   code_scheme=CodeSchemes.MOGADISHU_SUB_DISTRICT),

        CodingPlan(raw_field="location_raw",
                   id_field="location_raw_id",
                   coded_field="district_coded",
                   time_field="location_time",
                   coda_filename="location.json",
                   analysis_file_key="district",
                   ws_code=CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("location"),
                   cleaner=somali.DemographicCleaner.clean_somalia_district,
                   code_scheme=CodeSchemes.SOMALIA_DISTRICT),

        CodingPlan(raw_field="location_raw",
                   id_field="location_raw_id",
                   coded_field="region_coded",
                   time_field="location_time",
                   coda_filename="location.json",
                   analysis_file_key="region",
                   ws_code=CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("location"),
                   cleaner=None,
                   code_scheme=CodeSchemes.SOMALIA_REGION),

        CodingPlan(raw_field="location_raw",
                   id_field="location_raw_id",
                   coded_field="state_coded",
                   time_field="location_time",
                   coda_filename="location.json",
                   analysis_file_key="state",
                   ws_code=CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("location"),
                   cleaner=None,
                   code_scheme=CodeSchemes.SOMALIA_STATE),

        CodingPlan(raw_field="location_raw",
                   id_field="location_raw_id",
                   coded_field="zone_coded",
                   time_field="location_time",
                   coda_filename="location.json",
                   analysis_file_key="zone",
                   ws_code=CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("location"),
                   cleaner=None,
                   code_scheme=CodeSchemes.SOMALIA_ZONE),
    ]

    SURVEY_CODING_PLANS = [
        CodingPlan(raw_field="gender_raw",
                   coded_field="gender_coded",
                   time_field="gender_time",
                   coda_filename="gender.json",
                   analysis_file_key="gender",
                   cleaner=somali.DemographicCleaner.clean_gender,
                   ws_code=CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("gender"),
                   code_scheme=CodeSchemes.GENDER),
    ]
    SURVEY_CODING_PLANS.extend(LOCATION_CODING_PLANS)
    SURVEY_CODING_PLANS.extend([
        CodingPlan(raw_field="age_raw",
                   coded_field="age_coded",
                   time_field="age_time",
                   coda_filename="age.json",
                   analysis_file_key="age",
                   ws_code=CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("age"),
                   cleaner=lambda text: PipelineConfiguration.clean_age_with_range_filter(text),
                   code_scheme=CodeSchemes.AGE),

        CodingPlan(raw_field="idp_camp_raw",
                   coded_field="idp_camp_coded",
                   time_field="idp_camp_time",
                   coda_filename="idp_camp.json",
                   analysis_file_key="idp_camp",
                   ws_code=CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("idp camp"),
                   cleaner=somali.DemographicCleaner.clean_yes_no,
                   code_scheme=CodeSchemes.IDP_CAMP),

        CodingPlan(raw_field="recently_displaced_raw",
                   coded_field="recently_displaced_coded",
                   time_field="recently_displaced_time",
                   coda_filename="recently_displaced.json",
                   analysis_file_key="recently_displaced",
                   ws_code=CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("recently displaced"),
                   cleaner=somali.DemographicCleaner.clean_yes_no,
                   code_scheme=CodeSchemes.RECENTLY_DISPLACED),

        CodingPlan(raw_field="household_language_raw",
                   coded_field="household_language_coded",
                   time_field="household_language_time",
                   coda_filename="household_language.json",
                   analysis_file_key="household_language",
                   ws_code=CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("household language"),
                   cleaner=None,
                   code_scheme=CodeSchemes.HOUSEHOLD_LANGUAGE),

        CodingPlan(raw_field="positive_impact_raw",
                   coded_field="positive_impact_coded",
                   time_field="positive_impact_time",
                   coda_filename="positive_impact.json",
                   analysis_file_key="positive_impact",
                   cleaner=somali.DemographicCleaner.clean_yes_no,
                   code_scheme=CodeSchemes.POSITIVE_IMPACT),

        CodingPlan(raw_field="useful_info_raw",
                   coded_field="useful_info_coded",
                   time_field="useful_info_time",
                   coda_filename="useful_info.json",
                   analysis_file_key="useful_info",
                   cleaner=somali.DemographicCleaner.clean_yes_no,
                   code_scheme=CodeSchemes.USEFUL_INFO),

        CodingPlan(raw_field="involvement_raw",
                   coded_field="involvement_coded",
                   time_field="involvement_time",
                   coda_filename="involvement.json",
                   analysis_file_key="involvement",
                   cleaner=somali.DemographicCleaner.clean_yes_no,
                   code_scheme=CodeSchemes.INVOLVEMENT),
    ])

    def __init__(self, rapid_pro_domain, rapid_pro_token_file_url, activation_flow_names, survey_flow_names,
                 rapid_pro_test_contact_uuids, phone_number_uuid_table, rapid_pro_key_remappings,
                 project_start_date, project_end_date, filter_test_messages,
                 flow_definitions_upload_url_prefix, recovery_csv_urls=None, drive_upload=None):
        """
        :param rapid_pro_domain: URL of the Rapid Pro server to download data from.
        :type rapid_pro_domain: str
        :param rapid_pro_token_file_url: GS URL of a text file containing the authorisation token for the Rapid Pro
                                         server.
        :type rapid_pro_token_file_url: str
        :param activation_flow_names: The names of the RapidPro flows that contain the radio show responses.
        :type: activation_flow_names: list of str
        :param survey_flow_names: The names of the RapidPro flows that contain the survey responses.
        :type: survey_flow_names: list of str
        :param rapid_pro_test_contact_uuids: Rapid Pro contact UUIDs of test contacts.
                                             Runs for any of those test contacts will be tagged with {'test_run': True},
                                             and dropped when the pipeline is in production mode.
        :type rapid_pro_test_contact_uuids: list of str
        :param phone_number_uuid_table: Configuration for the Firestore phone number <-> uuid table.
        :type phone_number_uuid_table: PhoneNumberUuidTable
        :param rapid_pro_key_remappings: List of rapid_pro_key -> pipeline_key remappings.
        :type rapid_pro_key_remappings: list of RapidProKeyRemapping
        :param project_start_date: When data collection started - all activation messages received before this date
                                   time will be dropped.
        :type project_start_date: datetime.datetime
        :param project_end_date: When data collection stopped - all activation messages received on or after this date
                                 time will be dropped.
        :type project_end_date: datetime.datetime
        :param filter_test_messages: Whether to filter out messages sent from the rapid_pro_test_contact_uuids
        :type filter_test_messages: bool
        :param flow_definitions_upload_url_prefix: The prefix of the GS URL to uploads serialised flow definitions to.
                                                   This prefix will be appended with the current datetime and the
                                                   ".json" file extension.
        :type flow_definitions_upload_url_prefix: str
        :param recovery_csv_urls: GS URLs to CSVs in Shaqadoon's recovery format, or None.
        :type recovery_csv_urls: list of str | None
        :param drive_upload: Configuration for uploading to Google Drive, or None.
                             If None, does not upload to Google Drive.
        :type drive_upload: DriveUploadPaths | None
        """
        self.rapid_pro_domain = rapid_pro_domain
        self.rapid_pro_token_file_url = rapid_pro_token_file_url
        self.activation_flow_names = activation_flow_names
        self.survey_flow_names = survey_flow_names
        self.rapid_pro_test_contact_uuids = rapid_pro_test_contact_uuids
        self.phone_number_uuid_table = phone_number_uuid_table
        self.recovery_csv_urls = recovery_csv_urls
        self.rapid_pro_key_remappings = rapid_pro_key_remappings
        self.project_start_date = project_start_date
        self.project_end_date = project_end_date
        self.filter_test_messages = filter_test_messages
        self.drive_upload = drive_upload
        self.flow_definitions_upload_url_prefix = flow_definitions_upload_url_prefix

        self.validate()

    @classmethod
    def from_configuration_dict(cls, configuration_dict):
        rapid_pro_domain = configuration_dict["RapidProDomain"]
        rapid_pro_token_file_url = configuration_dict["RapidProTokenFileURL"]
        activation_flow_names = configuration_dict["ActivationFlowNames"]
        survey_flow_names = configuration_dict["SurveyFlowNames"]
        recovery_csv_urls = configuration_dict.get("RecoveryCSVURLs")
        rapid_pro_test_contact_uuids = configuration_dict["RapidProTestContactUUIDs"]

        phone_number_uuid_table = PhoneNumberUuidTable.from_configuration_dict(configuration_dict["PhoneNumberUuidTable"])

        rapid_pro_key_remappings = []
        for remapping_dict in configuration_dict["RapidProKeyRemappings"]:
            rapid_pro_key_remappings.append(RapidProKeyRemapping.from_configuration_dict(remapping_dict))

        project_start_date = isoparse(configuration_dict["ProjectStartDate"])
        project_end_date = isoparse(configuration_dict["ProjectEndDate"])

        filter_test_messages = configuration_dict["FilterTestMessages"]

        drive_upload_paths = None
        if "DriveUpload" in configuration_dict:
            drive_upload_paths = DriveUpload.from_configuration_dict(configuration_dict["DriveUpload"])

        flow_definitions_upload_url_prefix = configuration_dict["FlowDefinitionsUploadURLPrefix"]

        return cls(rapid_pro_domain, rapid_pro_token_file_url, activation_flow_names, survey_flow_names,
                   rapid_pro_test_contact_uuids, phone_number_uuid_table, rapid_pro_key_remappings,
                   project_start_date, project_end_date, filter_test_messages,
                   flow_definitions_upload_url_prefix, recovery_csv_urls, drive_upload_paths)

    @classmethod
    def from_configuration_file(cls, f):
        return cls.from_configuration_dict(json.load(f))
    
    def validate(self):
        validators.validate_string(self.rapid_pro_domain, "rapid_pro_domain")
        validators.validate_string(self.rapid_pro_token_file_url, "rapid_pro_token_file_url")

        validators.validate_list(self.activation_flow_names, "activation_flow_names")
        for i, activation_flow_name in enumerate(self.activation_flow_names):
            validators.validate_string(activation_flow_name, f"activation_flow_names[{i}]")

        validators.validate_list(self.survey_flow_names, "survey_flow_names")
        for i, survey_flow_name in enumerate(self.survey_flow_names):
            validators.validate_string(survey_flow_name, f"survey_flow_names[{i}]")

        if self.recovery_csv_urls is not None:
            validators.validate_list(self.recovery_csv_urls, "recovery_csv_urls")
            for i, recovery_csv_url in enumerate(self.recovery_csv_urls):
                validators.validate_string(recovery_csv_url, f"recovery_csv_urls[{i}]")

        validators.validate_list(self.rapid_pro_test_contact_uuids, "rapid_pro_test_contact_uuids")
        for i, contact_uuid in enumerate(self.rapid_pro_test_contact_uuids):
            validators.validate_string(contact_uuid, f"rapid_pro_test_contact_uuids[{i}]")

        assert isinstance(self.phone_number_uuid_table, PhoneNumberUuidTable)
        self.phone_number_uuid_table.validate()

        validators.validate_list(self.rapid_pro_key_remappings, "rapid_pro_key_remappings")
        for i, remapping in enumerate(self.rapid_pro_key_remappings):
            assert isinstance(remapping, RapidProKeyRemapping), \
                f"rapid_pro_key_mappings[{i}] is not of type RapidProKeyRemapping"
            remapping.validate()

        validators.validate_datetime(self.project_start_date, "project_start_date")
        validators.validate_datetime(self.project_end_date, "project_end_date")

        validators.validate_bool(self.filter_test_messages, "filter_test_messages")

        if self.drive_upload is not None:
            assert isinstance(self.drive_upload, DriveUpload), \
                "drive_upload is not of type DriveUpload"
            self.drive_upload.validate()

        validators.validate_string(self.flow_definitions_upload_url_prefix, "flow_definitions_upload_url_prefix")


class PhoneNumberUuidTable(object):
    def __init__(self, firebase_credentials_file_url, table_name):
        """
        :param firebase_credentials_file_url: GS URL to the private credentials file for the Firebase account where
                                                 the phone number <-> uuid table is stored.
        :type firebase_credentials_file_url: str
        :param table_name: Name of the data <-> uuid table in Firebase to use.
        :type table_name: str
        """
        self.firebase_credentials_file_url = firebase_credentials_file_url
        self.table_name = table_name

        self.validate()

    @classmethod
    def from_configuration_dict(cls, configuration_dict):
        firebase_credentials_file_url = configuration_dict["FirebaseCredentialsFileURL"]
        table_name = configuration_dict["TableName"]

        return cls(firebase_credentials_file_url, table_name)

    def validate(self):
        validators.validate_url(self.firebase_credentials_file_url, "firebase_credentials_file_url", scheme="gs")
        validators.validate_string(self.table_name, "table_name")


class RapidProKeyRemapping(object):
    def __init__(self, is_activation_message, rapid_pro_key, pipeline_key):
        """
        :param is_activation_message: Whether this re-mapping contains an activation message (activation messages need
                                   to be handled differently because they are not always in the correct flow)
        :type is_activation_message: bool
        :param rapid_pro_key: Name of key in the dataset exported via RapidProTools.
        :type rapid_pro_key: str
        :param pipeline_key: Name to use for that key in the rest of the pipeline.
        :type pipeline_key: str
        """
        self.is_activation_message = is_activation_message
        self.rapid_pro_key = rapid_pro_key
        self.pipeline_key = pipeline_key
        
        self.validate()

    @classmethod
    def from_configuration_dict(cls, configuration_dict):
        is_activation_message = configuration_dict.get("IsActivationMessage", False)
        rapid_pro_key = configuration_dict["RapidProKey"]
        pipeline_key = configuration_dict["PipelineKey"]
        
        return cls(is_activation_message, rapid_pro_key, pipeline_key)
    
    def validate(self):
        validators.validate_bool(self.is_activation_message, "is_activation_message")
        validators.validate_string(self.rapid_pro_key, "rapid_pro_key")
        validators.validate_string(self.pipeline_key, "pipeline_key")


class DriveUpload(object):
    def __init__(self, drive_credentials_file_url, production_upload_path, messages_upload_path,
                 individuals_upload_path, traced_data_upload_path):
        """
        :param drive_credentials_file_url: GS URL to the private credentials file for the Drive service account to use
                                           to upload the output files.
        :type drive_credentials_file_url: str
        :param production_upload_path: Path in the Drive service account's "Shared with Me" directory to upload the
                                       production CSV to.
        :type production_upload_path: str
        :param messages_upload_path: Path in the Drive service account's "Shared with Me" directory to upload the
                                     messages analysis CSV to.
        :type messages_upload_path: str
        :param individuals_upload_path: Path in the Drive service account's "Shared with Me" directory to upload the
                                        individuals analysis CSV to.
        :type individuals_upload_path: str
        :param traced_data_upload_path: Path in the Drive service account's "Shared with Me" directory to upload the
                                        serialized TracedData from this pipeline run to.
        :type traced_data_upload_path: str
        """
        self.drive_credentials_file_url = drive_credentials_file_url
        self.production_upload_path = production_upload_path
        self.messages_upload_path = messages_upload_path
        self.individuals_upload_path = individuals_upload_path
        self.traced_data_upload_path = traced_data_upload_path

        self.validate()

    @classmethod
    def from_configuration_dict(cls, configuration_dict):
        drive_credentials_file_url = configuration_dict["DriveCredentialsFileURL"]
        production_upload_path = configuration_dict["ProductionUploadPath"]
        messages_upload_path = configuration_dict["MessagesUploadPath"]
        individuals_upload_path = configuration_dict["IndividualsUploadPath"]
        traced_data_upload_path = configuration_dict["TracedDataUploadPath"]

        return cls(drive_credentials_file_url, production_upload_path, messages_upload_path,
                   individuals_upload_path, traced_data_upload_path)

    def validate(self):
        validators.validate_string(self.drive_credentials_file_url, "drive_credentials_file_url")
        assert urlparse(self.drive_credentials_file_url).scheme == "gs", "DriveCredentialsFileURL needs to be a gs " \
                                                                         "URL (i.e. of the form gs://bucket-name/file)"

        validators.validate_string(self.production_upload_path, "production_upload_path")
        validators.validate_string(self.messages_upload_path, "messages_upload_path")
        validators.validate_string(self.individuals_upload_path, "individuals_upload_path")
        validators.validate_string(self.traced_data_upload_path, "traced_data_upload_path")
