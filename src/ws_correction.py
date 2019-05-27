import time

from core_data_modules.logging import Logger
from core_data_modules.traced_data import Metadata
from core_data_modules.traced_data.io import TracedDataCodaV2IO

from src.lib import PipelineConfiguration
from src.lib.pipeline_configuration import CodeSchemes

log = Logger(__name__)


class WSCorrection(object):
    @staticmethod
    def move_wrong_scheme_messages(user, data, coda_input_dir):
        log.info("Importing manually coded Coda files to '_WS_correct_dataset' coded fields...")
        for plan in PipelineConfiguration.RQA_CODING_PLANS + PipelineConfiguration.SURVEY_CODING_PLANS:
            TracedDataCodaV2IO.compute_message_ids(user, data, plan.raw_field, plan.id_field + "_WS")
            with open(f"{coda_input_dir}/{plan.coda_filename}") as f:
                TracedDataCodaV2IO.import_coda_2_to_traced_data_iterable(
                    user, data, plan.id_field + "_WS",
                    {f"{plan.coded_field}_WS_correct_dataset": CodeSchemes.WS_CORRECT_DATASET}, f
                )

        # TODO: Check for coding errors i.e. WS but no correct_dataset or correct_dataset but no WS

        ws_code_to_raw_field_map = dict()
        for plan in PipelineConfiguration.RQA_CODING_PLANS + PipelineConfiguration.SURVEY_CODING_PLANS:
            if plan.ws_code is not None:
                ws_code_to_raw_field_map[plan.ws_code.code_id] = plan.raw_field

        log.info("Computing WS re-maps...")
        corrected_data = []
        for td in data:
            log.debug(f"Starting TracedData {td['uid']}. Raw keys:")
            for plan in PipelineConfiguration.RQA_CODING_PLANS + PipelineConfiguration.SURVEY_CODING_PLANS:
                log.debug(f"{plan.raw_field}: {td.get(plan.raw_field)}")

            moves = dict()  # dict of raw source_field -> target_field

            # Detect all the moves that need to happen for this TracedData item
            for plan in PipelineConfiguration.RQA_CODING_PLANS + PipelineConfiguration.SURVEY_CODING_PLANS:
                if plan.raw_field not in td:
                    continue

                ws_code = CodeSchemes.WS_CORRECT_DATASET.get_code_with_id(td[f"{plan.coded_field}_WS_correct_dataset"]["CodeID"])
                if ws_code.code_type == "Normal":
                    log.debug(f"Detected redirect from {plan.raw_field} -> {ws_code_to_raw_field_map.get(ws_code.code_id, ws_code.code_id)} for message {td[plan.raw_field]}")
                    moves[plan.raw_field] = ws_code_to_raw_field_map.get(ws_code.code_id)
            log.debug(f"Moves for this TracedData: {moves}")

            updates = dict()
            # For each of the raw fields: if the data is moving, clear the raw_field. If it's not, copy it through
            # to the updates dictionary and include a source field.
            for plan in PipelineConfiguration.RQA_CODING_PLANS + PipelineConfiguration.SURVEY_CODING_PLANS:
                if plan.raw_field in moves.keys():
                    updates[plan.raw_field] = []
                elif plan.raw_field in td:
                    updates[plan.raw_field] = [td[plan.raw_field]]
                    updates[f"{plan.raw_field}_source(s)"] = [plan.raw_field]

            # For each move, set the target field in the updates dictionary.
            for source_field, target_field in moves.items():
                # TODO: If constructing from data moved from surveys, only do so once.
                #       Can possibly do this by logging which raw fields have been moved from surveys to RQAs here,
                #       and skipping moves that we've seen before.
                log.debug(f"Target field {target_field} has value {td.get(target_field)}")

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
            log.debug(f"Updates for this TracedData: {updates}")

            # Convert from list format to concatenated string format.
            updates = {k: None if len(v) == 0 else "; ".join(v) for k, v in updates.items()}
            log.debug(f"Updates for this TracedData: {updates}")

            # Hide the keys currently in the TracedData which would otherwise be updated with the value None.
            td.hide_keys({k for k, v in updates.items() if v is None}.intersection(td.keys()),
                         Metadata(user, Metadata.get_call_location(), time.time()))

            # For each RQA field with data, create a TracedData item with the current history, all survey keys,
            # and just that one RQA field.
            rqa_fields_with_messages = {plan.raw_field for plan in PipelineConfiguration.RQA_CODING_PLANS
                                        if updates.get(plan.raw_field) is not None}
            survey_updates = {plan.raw_field: updates[plan.raw_field] for plan in PipelineConfiguration.SURVEY_CODING_PLANS
                              if updates.get(plan.raw_field) is not None}
            for rqa_field in rqa_fields_with_messages:
                td_updates = dict(survey_updates)
                td_updates[rqa_field] = updates[rqa_field]

                corrected_td = td.copy()
                corrected_td.hide_keys((rqa_fields_with_messages - {rqa_field}).intersection(td.keys()),
                                       Metadata(user, Metadata.get_call_location(), time.time()))
                corrected_td.append_data(td_updates, Metadata(user, Metadata.get_call_location(), time.time()))
                corrected_data.append(corrected_td)

                log.debug(f"Created TracedData with data:")
                for plan in PipelineConfiguration.RQA_CODING_PLANS + PipelineConfiguration.SURVEY_CODING_PLANS:
                    log.debug(f"{plan.raw_field}: {corrected_td.get(plan.raw_field)}")

        return corrected_data
