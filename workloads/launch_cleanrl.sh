#!/bin/bash

container_name="aluno_bryan-$1"
shift

# Run the Docker container with the provided arguments
CONTAINER_ID=$(docker run -d --gpus '"device=2"' --cpus=16.0 --memory=16g \
    -v /raid/bryan/sliding-puzzle-env:/sldp \
    -v /raid/bryan/cleanrl/runs:/sliding-puzzle/runs \
    --name "$container_name" \
    aluno_bryan-sldp_cleanrl \
    "$@")

# The container is runnig detached, but we block this thread until finished
EXIT_CODE=$(docker wait $CONTAINER_ID)
exit $EXIT_CODE