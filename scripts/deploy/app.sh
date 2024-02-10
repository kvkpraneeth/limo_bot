#!/bin/bash

source $WORKSPACE_PATH/devel/setup.bash

sim="robot"

while getopts 's' opt; do
    case "$opt" in
        s)
            sim="gazebo"
            ;;
    esac
done
shift "$(($OPTIND -1))"

if [ "$sim" == "gazebo" ]; then
    roslaunch limo_gazebo_sim limo_four_diff.launch
else
    roslaunch limo_bringup limo_start.launch
fi