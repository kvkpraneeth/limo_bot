#!/bin/bash

cd $WORKSPACE_PATH
source /opt/ros/$ROS_DISTRO/setup.bash
catkin build
echo "source $WORKSPACE_PATH/devel/setup.bash" >> /root/.bashrc