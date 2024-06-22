#!/bin/bash
# {"requirements": {"ram": 8, "vram": 12, "ramp_up_time": 30}}

current_file=$(basename "${BASH_SOURCE[0]}" .sh)
echo "Current workload: $current_file"
./workloads/launch.sh echo "Hello, World!"