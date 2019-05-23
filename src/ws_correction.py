from core_data_modules.logging import Logger
from core_data_modules.traced_data.io import TracedDataCodaV2IO

from src.lib import PipelineConfiguration
from src.lib.pipeline_configuration import CodeSchemes

log = Logger(__name__)


class WSCorrection(object):
    @staticmethod
    def move_wrong_scheme_messages(user, data, coda_input_dir):
        log.info("Importing manually coded Coda files to '_WS_correct_dataset' coded fields...")
        for plan in PipelineConfiguration.SURVEY_CODING_PLANS:
            TracedDataCodaV2IO.compute_message_ids(user, data, plan.raw_field, plan.id_field + "_WS")
            with open(f"{coda_input_dir}/{plan.coda_filename}") as f:
                TracedDataCodaV2IO.import_coda_2_to_traced_data_iterable(
                    user, data, plan.id_field + "_WS",
                    {f"{plan.coded_field}_WS_correct_dataset": CodeSchemes.WS_CORRECT_DATASET}, f
                )

        dataset_map = {
            CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("age").code_id: "age_raw",
            CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("gender").code_id: "gender_raw",
            CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("location").code_id: "location_raw",
            CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("recently displaced").code_id:
                "recently_displaced_raw",
            CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("idp camp").code_id: "idp_camp_raw",
            CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("hh language").code_id: "hh_language_raw",
            CodeSchemes.WS_CORRECT_DATASET.get_code_with_match_value("s02e01").code_id: "rqa_s02e01_raw",
        }

        log.info("Computing WS re-maps...")
        for td in data:
            log.debug(f"Starting TracedData {td['uid']}. Raw keys:")
            for plan in PipelineConfiguration.SURVEY_CODING_PLANS:
                log.debug(f"{plan.raw_field}: {td.get(plan.raw_field)}")

            moves = dict()  # dict of raw_field_from -> raw_field_to

            # Detect all the moves that need to happen for this TracedData item
            for plan in PipelineConfiguration.SURVEY_CODING_PLANS:
                if plan.raw_field not in td:
                    continue

                ws_code = CodeSchemes.WS_CORRECT_DATASET.get_code_with_id(td[f"{plan.coded_field}_WS_correct_dataset"]["CodeID"])
                if ws_code.code_type == "Normal":
                    log.debug(f"Detected redirect from {plan.raw_field} -> {dataset_map.get(ws_code.code_id, ws_code.code_id)} for message {td[plan.raw_field]}")
                    moves[plan.raw_field] = dataset_map.get(ws_code.code_id)
            log.debug(f"Moves for this TracedData: {moves}")

            updates = dict()
            # Clear data in source fields, preserve data that isn't moving
            for plan in PipelineConfiguration.SURVEY_CODING_PLANS:
                if plan.raw_field in moves.keys():
                    updates[plan.raw_field] = []
                elif plan.raw_field in td:
                    updates[plan.raw_field] = [td[plan.raw_field]]
                    updates[f"{plan.raw_field}_source(s)"] = [plan.raw_field]

            # Apply all the moves
            for source_field, target_field in moves.items():
                log.debug(f"Target field {target_field} has value {td.get(target_field)}")

                # TODO: Skip cases where source_field == target_field?
                # TODO: Otherwise fields containing 'X' become 'X; X' after this step

                # If the target field has not been set, we can safely write the source data to here.
                # Otherwise, append it to the previous data (which may have originated from target data not moving or
                # from another message being moved to here)
                if len(updates.get(target_field, [])) == 0:  # target_field not in updates:
                    updates[target_field] = [td[source_field]]
                    updates[f"{target_field}_source(s)"] = [source_field]
                else:
                    updates[target_field].append(td[source_field])
                    updates[f"{target_field}_source(s)"].append(source_field)

                # TODO: Change sources to be a list of dicts with nicer Metadata

                # TODO: Update TracedData with the new dictionary
            log.debug(f"Updates for this TracedData: {updates}")

        return data
