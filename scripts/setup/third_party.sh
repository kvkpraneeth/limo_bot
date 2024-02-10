#!/bin/bash

cd $THIRD_PARTY_PATH

# Installing ydlidar_sdk
cd ydlidar_sdk
mkdir build
cd build
cmake ..
make
sudo make install