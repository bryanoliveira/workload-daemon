#!/bin/bash
# {"requirements": {"ram": 4, "vram": 2, "ramp_up_time": 30}}

# Get the current file's name without extension
current_file=$(basename "${BASH_SOURCE[0]}" .sh)
echo "Current workload: $current_file"
for seed in 176 594 907; do # 267 769
    ./workloads/launch_cleanrl.sh ${current_file}_${seed} \
    python ppo.py --seed $seed \
    --env_configs '{"w": 4, "variation": "image", "image_folder": "imagenet-1k", "image_pool_size": 8}' \
    --total_timesteps 100000000 \
    --early_stop_patience 100 \
    --hidden_layers 1
done
