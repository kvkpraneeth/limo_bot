#!/bin/bash

run_docker() {
    xhost +local:root # Giving display privileges

    # -it is for interactive, tty
    # --privileged for accessing /dev contents
    # --net=host to share the same network as host machine. TL;DR same IP.
    docker run -it --privileged --net=host \
    --name agilex \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    -v $PWD/app.sh:/root/app.sh \
    -v /dev:/dev \
    $@
}

stop_docker() {
    docker stop agilex && docker rm agilex
    xhost -local:root # Remove display privileges
}