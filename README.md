# Workload Daemon

The Workload Daemon is a bash script that manages and executes workloads (scripts) based on system resource availability. It's designed to queue and run scripts while respecting RAM and VRAM constraints.

## Setup

1. Ensure you have `bash`, `jq`, and `nvidia-smi` (for NVIDIA GPUs) installed on your system.
2. Clone this repo.
3. Edit `workloads/launch.sh` to contain the base execution script for your workloads.
4. Place your workloads in the `workloads/1.to_run` folder.

## Directory Structure

The daemon creates and uses the following directory structure:

```
workloads/
├── 1.to_run/
├── 2.queued/
├── 3.running/
├── 4.executed/
└── 4.failed/
```

## Usage

1. Start the daemon:
   ```
   ./daemon.sh
   ```

2. The daemon will automatically process scripts from `1.to_run/` through the various stages.

## Script Requirements

You can specify resource requirements for your scripts by adding a JSON comment as the second line:

```bash
#!/bin/bash
# {"requirements": {"ram": 8, "vram": 4, "ramp_up_time": 60}}

# Your script content here
```

- `ram`: Minimum available RAM in GB
- `vram`: Minimum available VRAM in GB
- `ramp_up_time`: Time to wait after starting the script (in seconds) for your workload to start using resources

## Environment Variables

You can customize the daemon's behavior using these environment variables:

- `MAX_RAM`: Maximum RAM usage (default: 0.5, i.e., 50% of total RAM)
- `MAX_VRAM`: Maximum VRAM usage (default: 0.5, i.e., 50% of total VRAM)
- `RAMP_UP_TIME`: Default time to wait between runs (default: 30 seconds)

Example:
```
MAX_RAM=0.7 MAX_VRAM=0.8 RAMP_UP_TIME=45 ./daemon.sh
```

## Monitoring

The daemon provides status updates in the console, including:
- Script movements between directories
- Resource availability and requirements
- Execution status

## Notes

- The daemon runs continuously, checking for new scripts every 10 seconds.
- Scripts are executed in the background, allowing multiple scripts to run concurrently if resources permit.
- Failed scripts are moved to the `4.failed/` directory for troubleshooting.