#!/bin/bash

set -e

IMAGE_NAME=adss-csap

while [[ $# -gt 0 ]]; do
    case "$1" in
        --profile-cpu)
            PROFILE_CPU=true
            CPU_PROFILE_OUTPUT_PATH="$2"
            shift 2;;
        --drive-upload)
            DRIVE_UPLOAD=true

            DRIVE_SERVICE_ACCOUNT_CREDENTIALS_URL=$2
            MESSAGES_DRIVE_PATH=$3
            INDIVIDUALS_DRIVE_PATH=$4
            PRODUCTION_DRIVE_PATH=$5
            shift 5;;
        --)
            shift
            break;;
        *)
            break;;
    esac
done


# Check that the correct number of arguments were provided.
if [[ $# -ne 17 ]]; then
    echo "Usage: ./docker-run.sh
    [--profile-cpu <profile-output-path>]
    [--drive-upload <drive-auth-file> <messages-drive-path> <individuals-drive-path> <production-drive-path>]
    <user> <phone-number-uuid-table-path>
    <s02e01-input-path> <s02e02-input-path> <s02e03-input-path> <s02e04-input-path> <s02e05-input-path> <s02e06-input-path>
    <s01-demog-input-path> <s02-demog-input-path> <prev-coded-dir> <json-output-path>
    <icr-output-dir> <coded-output-dir> <messages-output-csv> <individuals-output-csv> <production-output-csv>"
    exit
fi

# Assign the program arguments to bash variables.
USER=$1
INPUT_PHONE_UUID_TABLE=$2
INPUT_S02E01=$3
INPUT_S02E02=$4
INPUT_S02E03=$5
INPUT_S02E04=$6
INPUT_S02E05=$7
INPUT_S02E06=$8
INPUT_S01_DEMOG=$9
INPUT_S02_DEMOG=${10}
PREV_CODED_DIR=${11}
OUTPUT_JSON=${12}
OUTPUT_ICR_DIR=${13}
OUTPUT_CODED_DIR=${14}
OUTPUT_MESSAGES_CSV=${15}
OUTPUT_INDIVIDUALS_CSV=${16}
OUTPUT_PRODUCTION_CSV=${17}

# Build an image for this pipeline stage.
docker build --build-arg INSTALL_CPU_PROFILER="$PROFILE_CPU" -t "$IMAGE_NAME" .

# Create a container from the image that was just built.
# When run, the container will:
#  - Copy the service account credentials from the google cloud storage url 'SERVICE_ACCOUNT_CREDENTIALS_URL',
#    if the --drive-upload flag has been set.
#    The google cloud storage access is authorised via volume mounting (-v in the docker container create command).
#  - Run the pipeline.
# The gcloud bucket access is authorised via volume mounting (-v in the docker container create command)
if [[ "$PROFILE_CPU" = true ]]; then
    PROFILE_CPU_CMD="pyflame -o /data/cpu.prof -t"
    SYS_PTRACE_CAPABILITY="--cap-add SYS_PTRACE"
fi
if [[ "$DRIVE_UPLOAD" = true ]]; then
    GSUTIL_CP_CMD="gsutil cp \"$DRIVE_SERVICE_ACCOUNT_CREDENTIALS_URL\" /root/.config/drive-service-account-credentials.json &&"
    DRIVE_UPLOAD_ARG="--drive-upload /root/.config/drive-service-account-credentials.json \"$MESSAGES_DRIVE_PATH\" \"$INDIVIDUALS_DRIVE_PATH\" \"$PRODUCTION_DRIVE_PATH\""
fi
CMD="
    $GSUTIL_CP_CMD \

    pipenv run $PROFILE_CPU_CMD python -u pipeline.py $DRIVE_UPLOAD_ARG \
    \"$USER\" /data/phone-number-uuid-table-input.json \
    /data/s02e01-input.json /data/s02e02-input.json /data/s02e03-input.json \
    /data/s02e04-input.json /data/s02e05-input.json /data/s02e06-input.json \
    /data/s01-demog-input.json /data/s02-demog-input.json /data/prev-coded \
    /data/output.json /data/output-icr /data/coded \
    /data/output-messages.csv /data/output-individuals.csv /data/output-production.csv \
"
container="$(docker container create ${SYS_PTRACE_CAPABILITY} -v=$HOME/.config/gcloud:/root/.config/gcloud -w /app "$IMAGE_NAME" /bin/bash -c "$CMD")"

function finish {
    # Tear down the container when done.
    docker container rm "$container" >/dev/null
}
trap finish EXIT

# Copy input data into the container
docker cp "$INPUT_PHONE_UUID_TABLE" "$container:/data/phone-number-uuid-table-input.json"
docker cp "$INPUT_S02E01" "$container:/data/s02e01-input.json"
docker cp "$INPUT_S02E02" "$container:/data/s02e02-input.json"
docker cp "$INPUT_S02E03" "$container:/data/s02e03-input.json"
docker cp "$INPUT_S02E04" "$container:/data/s02e04-input.json"
docker cp "$INPUT_S02E05" "$container:/data/s02e05-input.json"
docker cp "$INPUT_S02E06" "$container:/data/s02e06-input.json"
docker cp "$INPUT_S01_DEMOG" "$container:/data/s01-demog-input.json"
docker cp "$INPUT_S02_DEMOG" "$container:/data/s02-demog-input.json"
if [[ -d "$PREV_CODED_DIR" ]]; then
    docker cp "$PREV_CODED_DIR" "$container:/data/prev-coded"
fi

# Run the container
docker start -a -i "$container"

# Copy the output data back out of the container
mkdir -p "$(dirname "$OUTPUT_JSON")"
docker cp "$container:/data/output.json" "$OUTPUT_JSON"

#mkdir -p "$OUTPUT_ICR_DIR"
#docker cp "$container:/data/output-icr/." "$OUTPUT_ICR_DIR"
#
#mkdir -p "$OUTPUT_CODED_DIR"
#docker cp "$container:/data/coded/." "$OUTPUT_CODED_DIR"
#
#mkdir -p "$(dirname "$OUTPUT_MESSAGES_CSV")"
#docker cp "$container:/data/output-messages.csv" "$OUTPUT_MESSAGES_CSV"
#
#mkdir -p "$(dirname "$OUTPUT_INDIVIDUALS_CSV")"
#docker cp "$container:/data/output-individuals.csv" "$OUTPUT_INDIVIDUALS_CSV"

mkdir -p "$(dirname "$OUTPUT_PRODUCTION_CSV")"
docker cp "$container:/data/output-production.csv" "$OUTPUT_PRODUCTION_CSV"

if [[ "$PROFILE_CPU" = true ]]; then
    mkdir -p "$(dirname "$CPU_PROFILE_OUTPUT_PATH")"
    docker cp "$container:/data/cpu.prof" "$CPU_PROFILE_OUTPUT_PATH"
fi