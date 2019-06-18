#!/bin/bash

set -e

# TODO: Change back to adss before merging to master
IMAGE_NAME=adss-analysis

# Check that the correct number of arguments were provided.
if [[ $# -ne 1 ]]; then
    echo "Usage: ./docker-run-analysis-scripts.sh
    <individuals-csv-path>"
    exit
fi

# Assign the program arguments to bash variables.
INPUT_INDIVIDUALS_CSV=$1

# Build an image for this pipeline stage.
docker build -t "$IMAGE_NAME" .

# Create a container from the image that was just built.
CMD="
    Rscript '1. validation_analysis.R' /app/analysis /data/individuals.csv /data/analysis-outputs && \
    Rscript '2. frequency_analysis.R' /app/analysis /data/analysis-outputs && \
    Rscript '3. regression_analysis.R' /app/analysis /data/analysis-outputs '/app/analysis/2. frequency_analysis.R'
"
container="$(docker container create -w /app/analysis "$IMAGE_NAME" /bin/bash -c "$CMD")"

function finish {
    # Tear down the container when done.
    docker container rm "$container" >/dev/null
}
trap finish EXIT

# Copy input data into the container
docker cp "$INPUT_INDIVIDUALS_CSV" "$container:/data/individuals.csv"

# Run the container
docker start -a -i "$container"

# Copy the output data back out of the container
# TODO
