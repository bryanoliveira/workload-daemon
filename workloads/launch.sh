#!/bin/bash

# This is an example script that implements the base command for all workloads
# Run the Docker container with the provided argument
CONTAINER_ID=$(docker run -d --rm alpine "$@")
EXIT_CODE=$(docker wait $CONTAINER_ID)
exit $EXIT_CODE