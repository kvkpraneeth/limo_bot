# ROS noetic Base
FROM ros:noetic

RUN apt-get update && apt-get upgrade -y

# http://wiki.ros.org/docker/Tutorials/Hardware%20Acceleration#nvidia-docker2
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN apt-get install --no-install-recommends -y \
    software-properties-common \
    vim

# Added updated mesa drivers for integration with cpu if gpu is missing
RUN add-apt-repository ppa:kisak/kisak-mesa && \
    apt-get update && apt-get upgrade -y

RUN apt-get install --no-install-recommends -y \
    python3-catkin-tools

# Source by default
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /root/.bashrc

COPY scripts/setup/ /root/scripts/setup

ENV THIRD_PARTY_PATH /root/third_party
COPY third_party/ $THIRD_PARTY_PATH/
RUN /root/scripts/setup/third_party.sh

ENV WORKSPACE_PATH /root/workspace
COPY workspace/ $WORKSPACE_PATH/src/

RUN rosdep update && cd $WORKSPACE_PATH && \
    rosdep install --from-paths src -y --ignore-src

RUN /root/scripts/setup/workspace.sh

RUN apt-get install --no-install-recommends -y \
    ros-$ROS_DISTRO-teleop-twist-keyboard