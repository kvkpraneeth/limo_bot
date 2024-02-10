# Containerized LIMO ROS

## Introduction

This package consists of dockerfiles and ros packages that aim to compile and execute limo robot in real life and gazebo. The documentation of this package is subdivided into individual elements in the `docs/` directory. Visit the docs folder to understand various elements involved.

## Installation

### Real-life limo robot setup

1. Transfer all the files to the robot through scp or git.
2. Build the docker with the following command:
    ```bash
    docker build --rm --no-cache -t agilex:noetic -f docker/robot.Dockerfile .
    ```

### Gazebo limo robot setup

1. Choose a capable device that can run gazebo.
2. Build the docker with the following command:
    ```bash
    docker build --rm --no-cache -t agilex:noetic_gazebo -f docker/gazebo.Dockerfile .
    ```

Note: The `--no-cache` option is to ensure apt-cache of the docker is updated. So it can be omitted upon running once, but should be run if the docker is used for more than 15 days.

## Run Instructions

### Real-life limo robot

```bash
cd scripts/deploy
./start.sh # This script automatically runs limo_start.launch on startup
#### OR ####
./devel.sh # Run this script for just starting the docker in a new bash session
```

### Gazebo limo robot

```bash
cd scripts/deploy
./start.sh -s # This script automatically runs limo_four_diff.launch on startup
#### OR ####
./devel.sh -s # Run this script for just starting the docker in a new bash session
```

### Configuration

1. To give the docker access to an nvidia gpu, pass the flag `-g` to `devel.sh` or `start.sh`
2. To change what `start.sh` should run on startup edit `scripts/deploy/app.sh`

## Design Notes

1. Why are certain externally developed directories not submodules:\
    a. `workspace/ydlidar_ros`: The original source for `ydlidar` has been updated, by `limo_ros` has not. For brevity, software has been directly uploaded.\
    b. `workspace/limo_gazebo`: Agilex's simulation repository contains all robot's simulation files, prompting a large repository to be added as submodule, to avoid this limo_gazebo is uploaded.