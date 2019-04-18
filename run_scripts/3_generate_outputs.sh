#!/usr/bin/env bash

set -e

while [[ $# -gt 0 ]]; do
    case "$1" in
        --profile-cpu)
            PROFILE_CPU=true
            CPU_PROFILE_OUTPUT_PATH="$2"

            CPU_PROFILE_ARG="--profile-cpu $CPU_PROFILE_OUTPUT_PATH"
            shift 2;;
        --)
            shift
            break;;
        *)
            break;;
    esac
done

if [[ $# -ne 4 ]]; then
    echo "Usage: ./3_generate_outputs.sh [--profile-cpu <cpu-profile-output-path>] <user> <google-cloud-credentials-file-path> <pipeline-configuration-file-path> <data-root>"
    echo "Generates the outputs needed downstream from raw data files generated by step 2 and uploads to Google Drive"
    exit
fi

USER=$1
GOOGLE_CLOUD_CREDENTIALS_FILE_PATH=$2
PIPELINE_CONFIGURATION=$3
DATA_ROOT=$4

mkdir -p "$DATA_ROOT/Coded Coda Files"
mkdir -p "$DATA_ROOT/Outputs"

cd ..
./docker-run-generate-outputs.sh ${CPU_PROFILE_ARG} \
    "$USER" "$PIPELINE_CONFIGURATION" "$GOOGLE_CLOUD_CREDENTIALS_FILE_PATH" "$DATA_ROOT/UUIDs/phone_uuids.json" \
    "$DATA_ROOT/Raw Data" "$DATA_ROOT/Coded Coda Files/" \
    "$DATA_ROOT/Outputs/traced_data.json" \
    "$DATA_ROOT/Outputs/ICR/" "$DATA_ROOT/Outputs/Coda Files/" \
    "$DATA_ROOT/Outputs/csap_s02_messages.csv" "$DATA_ROOT/Outputs/csap_s02_individuals.csv" \
    "$DATA_ROOT/Outputs/csap_s02_production.csv"
