#!/bin/bash

set -e

IMAGE_NAME=adss

while [[ $# -gt 0 ]]; do
    case "$1" in
        --profile-cpu)
            PROFILE_CPU=true
            CPU_PROFILE_OUTPUT_PATH="$2"
            shift 2;;
        --)
            shift
            break;;
        *)
            break;;
    esac
done

# Check that the correct number of arguments were provided.
if [[ $# -ne 2 ]]; then
    echo "Usage: ./docker-run-poll-flow-definitions.sh
    [--profile-cpu <profile-output-path>]
    <google-cloud-credentials-file-path> <pipeline-configuration-file-path>"
    exit
fi

# Assign the program arguments to bash variables.
GOOGLE_CLOUD_CREDENTIALS_FILE_PATH=$1
PIPELINE_CONFIGURATION=$2

# Build an image for this pipeline stage.
docker build -t "$IMAGE_NAME" .

# Create a container from the image that was just built.
if [[ "$PROFILE_CPU" = true ]]; then
    PROFILE_CPU_CMD="pyflame -o /data/cpu.prof -t"
    SYS_PTRACE_CAPABILITY="--cap-add SYS_PTRACE"
fi
CMD="pipenv run $PROFILE_CPU_CMD python -u fetch_flow_definitions.py \
    /credentials/google-cloud-credentials.json /data/pipeline-configuration.json
"
container="$(docker container create ${SYS_PTRACE_CAPABILITY} -w /app "$IMAGE_NAME" /bin/bash -c "$CMD")"

function finish {
    # Tear down the container when done.
    docker container rm "$container" >/dev/null
}
trap finish EXIT

# Copy input data into the container
docker cp "$GOOGLE_CLOUD_CREDENTIALS_FILE_PATH" "$container:/credentials/google-cloud-credentials.json"
docker cp "$PIPELINE_CONFIGURATION" "$container:/data/pipeline-configuration.json"

# Run the container
docker start -a -i "$container"
