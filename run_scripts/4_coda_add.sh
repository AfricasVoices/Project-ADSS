#!/usr/bin/env bash

set -e

if [[ $# -ne 3 ]]; then
    echo "Usage: ./coda_add.sh <coda-auth-file> <coda-tools-root> <data-root>"
    echo "Uploads coded messages datasets from '<data-root>/Outputs/Coda Files' to Coda"
    exit
fi

AUTH=$1
CODA_TOOLS_ROOT=$2
DATA_ROOT=$3

PROJECT_NAME="ADSS"
DATASETS=(
    "s02e01"

    "gender"
    "location"
    "age"
    "idp_camp"
    "recently_displaced"
    "household_language"
)

cd "$CODA_TOOLS_ROOT"

for DATASET in ${DATASETS[@]}
do
    echo "Pushing messages data to ${PROJECT_NAME}_${DATASET}..."

    pipenv run python add.py "$AUTH" "${PROJECT_NAME}_${DATASET}" messages "$DATA_ROOT/Outputs/Coda Files/$DATASET.json"
done
