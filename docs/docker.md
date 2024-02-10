# Docker

To learn the basics of docker, any youtube video/ official documentation will do a better job. You should read this document post understanding the basics of what docker exactly is. This document will cover the docker structure and scripts used.

## Dockerfiles

In the `docker` directory, there are two `Dockerfile`s, one for a real robot, and the other for gazebo. The first twenty or so lines are the same for every `Dockerfile`, we start with a noetic base, run some updates, install basic required packages, and catkin.

After this point we copy in `scripts/setup` to get scripts that will setup the required software for us. For the real robot, we copy in `third_party` directory to get ydlidar's sdk, and the setup scripts has a `third_party.sh` to compile this sdk. Similarly, for both gazebo and real robot, we copy the `workspace` directory and run the `workspace.sh` script to build the packages.

Note: As a rule of thumb, all non-ros software will be in `third_party` and the ros software in `workspace`.

## Dockerignore

If you notice the packages in workspace directory this is it's structure and contents:
```
workspace
├── limo_gazebo
│   ├── image
│   ├── limo_description
│   └── limo_gazebo_sim
├── limo_ros
│   ├── limo_base
│   ├── limo_bringup
│   └── limo_description
└── ydlidar_ros
```
There is a conflicting package `limo_description`, one is required by the real robot and the other by gazebo. Here, we employ `.dockerignore` file. By adding `limo_gazebo` to the `robot.Dockerfile.dockerignore` file, it will ignore it's existence and hence solving the conflict.

## Deploy Scripts

1. `base.sh`: Contains functions to run and stop the docker. Read the comments in the file for a detailed explanation of the command and functions.
2. `start.sh`: Runs the function from `base.sh` and starts `app.sh` on starting the docker. For more information refer to `README`'s run instructions section.
3. `devel.sh`: Runs the function from `base.sh` and starts a bash session on starting the docker. For more information refer to `README`'s run instructions section.
4. `stop.sh`: Stops the docker

Note: To enter a docker that is currently running, in a new terminal run `docker exec -it agilex bash`