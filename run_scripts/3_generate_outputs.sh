#!/usr/bin/env bash

set -e

while [[ $# -gt 0 ]]; do
    case "$1" in
        --profile-cpu)
            PROFILE_CPU=true
            CPU_PROFILE_OUTPUT_PATH="$2"

            CPU_PROFILE_ARG="--profile-cpu $CPU_PROFILE_OUTPUT_PATH"
            shift 2;;
        --drive-upload)
            DRIVE_SERVICE_ACCOUNT_CREDENTIALS_URL=$2
            DRIVE_UPLOAD_DIR=$3

            DRIVE_UPLOAD_ARG="--drive-upload $DRIVE_SERVICE_ACCOUNT_CREDENTIALS_URL $DRIVE_UPLOAD_DIR/csap_s02_messages.csv $DRIVE_UPLOAD_DIR/csap_s02_individuals.csv $DRIVE_UPLOAD_DIR/csap_s02_production.csv"
            shift 3;;
        --)
            shift
            break;;
        *)
            break;;
    esac
done

if [[ $# -ne 2 ]]; then
    echo "Usage: ./3_generate_outputs.sh [--profile-cpu <cpu-profile-output-path>]  [--drive-upload <drive-service-account-credentials-url> <drive-upload-dir>] <user> <data-root>"
    echo "Generates the outputs needed downstream from raw data files generated by step 2 and uploads to Google Drive"
    exit
fi

USER=$1
DATA_ROOT=$2

mkdir -p "$DATA_ROOT/Coded Coda Files"
mkdir -p "$DATA_ROOT/Outputs"

cd ..
./docker-run.sh ${CPU_PROFILE_ARG} ${DRIVE_UPLOAD_ARG} \
    "$USER" "$DATA_ROOT/UUIDs/phone_uuids.json" \
    "$DATA_ROOT/Raw Data/csap_s02e01_activation.json" "$DATA_ROOT/Raw Data/csap_s02e02_activation.json" \
    "$DATA_ROOT/Raw Data/csap_s02e03_activation.json" "$DATA_ROOT/Raw Data/csap_s02e04_activation.json" \
    "$DATA_ROOT/Raw Data/csap_s02e05_activation.json" "$DATA_ROOT/Raw Data/csap_s02e06_activation.json" \
    "$DATA_ROOT/Raw Data/csap_demog.json" "$DATA_ROOT/Raw Data/csap_s02_demog.json" "$DATA_ROOT/Coded Coda Files/" \
    "$DATA_ROOT/Outputs/traced_data.json" \
    "$DATA_ROOT/Outputs/ICR/" "$DATA_ROOT/Outputs/Coda Files/" \
    "$DATA_ROOT/Outputs/csap_s02_messages.csv" "$DATA_ROOT/Outputs/csap_s02_individuals.csv" \
    "$DATA_ROOT/Outputs/csap_s02_production.csv"
