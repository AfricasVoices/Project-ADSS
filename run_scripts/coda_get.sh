#!/usr/bin/env bash

set -e

if [[ $# -ne 3 ]]; then
    echo "Usage: ./coda_get.sh <coda-auth-file> <coda-tools-root> <data-root>"
    echo "Downloads coded messages datasets from Coda to '<data-root>/Coded Coda Files'"
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
mkdir -p "$DATA_ROOT/Coded Coda Files"

for DATASET in ${DATASETS@]}
do
    echo "Getting messages data from ${PROJECT_NAME}_${DATASET}..."

    pipenv run python get.py "$AUTH" "${PROJECT_NAME}_${DATASET}" messages >"$DATA_ROOT/Coded Coda Files/$DATASET.json"
done
