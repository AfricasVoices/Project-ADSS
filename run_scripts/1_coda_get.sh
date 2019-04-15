#!/usr/bin/env bash

set -e

if [[ $# -ne 3 ]]; then
    echo "Usage: ./1_coda_get.sh <coda-auth-file> <coda-v2-root> <data-root>"
    echo "Downloads coded messages datasets from Coda to '<data-root>/Coded Coda Files'"
    exit
fi

AUTH=$1
CODA_V2_ROOT=$2
DATA_ROOT=$3

./checkout_coda_v2.sh "$CODA_V2_ROOT"

PROJECT_NAME="ADSS"
DATASETS=(
    "s02e01"
    "s02e02"
    "s02e03"
    "s02e04"
    "s02e05"
    "s02e06"

    "gender"
    "location"
    "age"
    "idp_camp"
    "recently_displaced"
    "household_language"

    "positive_impact"
    "useful_info"
    "involvement"
)

cd "$CODA_V2_ROOT/data_tools"
mkdir -p "$DATA_ROOT/Coded Coda Files"

for DATASET in ${DATASETS[@]}
do
    echo "Getting messages data from ${PROJECT_NAME}_${DATASET}..."

    pipenv run python get.py "$AUTH" "${PROJECT_NAME}_${DATASET}" messages >"$DATA_ROOT/Coded Coda Files/$DATASET.json"
done
