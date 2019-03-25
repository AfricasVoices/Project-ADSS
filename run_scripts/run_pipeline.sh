#!/usr/bin/env bash

set -e

if [[ $# -ne 10 ]]; then
    echo "Usage: ./run_pipeline.sh"
    echo "  <user> <pipeline-configuration-json>"
    echo "  <coda-pull-credentials-path> <coda-push-credentials-path> <avf-bucket-credentials-path>"
    echo "  <drive-service-account-credentials-url> <rapid-pro-tools-root> <coda-tools-root>"
    echo "  <data-root> <data-backup-dir>"
    echo "Runs the pipeline end-to-end (data fetch, coda fetch, output generation, Drive upload, Coda upload, data backup)"
    exit
fi

USER=$1
PIPELINE_CONFIGURATION=$2
CODA_PULL_CREDENTIALS_PATH=$3
CODA_PUSH_CREDENTIALS_PATH=$4
AVF_BUCKET_CREDENTIALS_PATH=$5
DRIVE_SERVICE_ACCOUNT_CREDENTIALS_URL=$6
RAPID_PRO_TOOLS_ROOT=$7
CODA_TOOLS_ROOT=$8
DATA_ROOT=$9
DATA_BACKUPS_DIR=${10}

./1_coda_get.sh "$CODA_PULL_CREDENTIALS_PATH" "$CODA_TOOLS_ROOT" "$DATA_ROOT"

pipenv run python 2_fetch_raw_data.py "$USER" "$AVF_BUCKET_CREDENTIALS_PATH" "$PIPELINE_CONFIGURATION" \
    "$RAPID_PRO_TOOLS_ROOT" "$DATA_ROOT"

./3_generate_outputs.sh "$USER" "$AVF_BUCKET_CREDENTIALS_PATH" "$PIPELINE_CONFIGURATION" "$DATA_ROOT"

./4_coda_add.sh "$CODA_PUSH_CREDENTIALS_PATH" "$CODA_TOOLS_ROOT" "$DATA_ROOT"

# Backup the project data directory
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
HASH=$(git rev-parse HEAD)
mkdir -p "$DATA_BACKUPS_DIR"
find "$DATA_ROOT" -type f -name '.DS_Store' -delete
cd "$DATA_ROOT"
tar -czvf "$DATA_BACKUPS_DIR/data-$DATE-$HASH.tar.gzip" .
