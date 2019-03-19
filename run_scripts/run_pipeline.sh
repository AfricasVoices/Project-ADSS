#!/usr/bin/env bash

set -e

if [[ $# -ne 10 ]]; then
    echo "Usage: ./run_pipeline.sh"
    echo "  <user> <coda-pull-credentials-path> <coda-push-credentials-path> <avf-bucket-credentials-path>"
    echo "  <drive-service-account-credentials-url> <rapid-pro-tools-root> <coda-tools-root> <data-root>"
    echo "  <drive-upload-dir> <data-backup-dir>"
    echo "Runs the pipeline end-to-end (data fetch, coda fetch, output generation, Drive upload, Coda upload, data backup)"
    exit
fi

USER=$1
CODA_PULL_CREDENTIALS_PATH=$2
CODA_PUSH_CREDENTIALS_PATH=$3
AVF_BUCKET_CREDENTIALS_PATH=$4
DRIVE_SERVICE_ACCOUNT_CREDENTIALS_URL=$5
RAPID_PRO_TOOLS_ROOT=$6
CODA_TOOLS_ROOT=$7
DATA_ROOT=$8
DRIVE_UPLOAD_DIR=$9
DATA_BACKUPS_DIR=${10}

./1_coda_get.sh "$CODA_PULL_CREDENTIALS_PATH" "$CODA_TOOLS_ROOT" "$DATA_ROOT"

pipenv run python 2_fetch_raw_data.py "$USER" "$AVF_BUCKET_CREDENTIALS_PATH" ../pipeline_config.json \
    "$RAPID_PRO_TOOLS_ROOT" "$DATA_ROOT"

./3_generate_outputs.sh --drive-upload "$DRIVE_SERVICE_ACCOUNT_CREDENTIALS_URL" "$DRIVE_UPLOAD_DIR" "$USER" "$AVF_BUCKET_CREDENTIALS_PATH" "$DATA_ROOT"

./4_coda_add.sh "$CODA_PUSH_CREDENTIALS_PATH" "$CODA_TOOLS_ROOT" "$DATA_ROOT"

# Backup the project data directory
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
HASH=$(git rev-parse HEAD)
mkdir -p "$DATA_BACKUPS_DIR"
find "$DATA_ROOT" -type f -name '.DS_Store' -delete
cd "$DATA_ROOT"
tar -czvf "$DATA_BACKUPS_DIR/data-$DATE-$HASH.tar.gzip" .
