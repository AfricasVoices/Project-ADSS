#!/usr/bin/env bash

set -e

if [[ $# -ne 10 ]]; then
    echo "Usage: "
    echo "Runs the pipeline end-to-end (data fetch, coda fetch, output generation, Drive upload, coda upload, data backup)"
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
DATA_PREV=${10}

pipenv run python 2_fetch_raw_data.py "$USER" "$AVF_BUCKET_CREDENTIALS_PATH" ../pipeline_config.json \
    "$RAPID_PRO_TOOLS_ROOT" "$DATA_ROOT"

./coda_get.sh "$CODA_PULL_CREDENTIALS_PATH" "$CODA_TOOLS_ROOT" "$DATA_ROOT"

./3_generate_outputs.sh --drive-upload "$DRIVE_SERVICE_ACCOUNT_CREDENTIALS_URL" "$DRIVE_UPLOAD_DIR" "$USER" "$DATA_ROOT"

./coda_add.sh "$CODA_PUSH_CREDENTIALS_PATH" "$CODA_TOOLS_ROOT" "$DATA_ROOT"

# Backup the project data directory
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
HASH=$(git rev-parse HEAD)
mkdir -p "$DATA_PREV"
find "$DATA_ROOT" -type f -name '.DS_Store' -delete
cd "$DATA_ROOT"
tar -czvf "$DATA_PREV/data-$DATE-$HASH.tar.gzip" .
