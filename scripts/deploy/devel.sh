#!/bin/bash

# Get base.sh funcs
source "$(dirname "$0")/base.sh"

stop_docker

# declare mode, use cpu by default
mode="cpu"

# declare sim, use no gazebo by default
sim="robot"

while getopts 'gsh' opt; do
    case "$opt" in
        g)
            mode="gpu"
            ;;
        s)
            sim="gazebo"
            ;;
        ?|h)
            echo "Usage: $(basename $0) [-g] [-s]"
            exit 1
            ;;
    esac
done
shift "$(($OPTIND -1))"

if [ "$mode" == "gpu" ]; then
    if [ "$sim" == "gazebo" ]; then
        run_docker --runtime=nvidia agilex:noetic_gazebo bash
    else
        run_docker --runtime=nvidia agilex:noetic bash
    fi
else
    if [ "$sim" == "gazebo" ]; then
        run_docker agilex:noetic_gazebo bash
    else
        run_docker agilex:noetic bash
    fi
fi