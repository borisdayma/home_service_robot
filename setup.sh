#!/bin/sh

# initialize environment to run project
# run from your home directory

# install required packages
sudo apt-get update
sudo apt-get install ros-kinetic-navigation

# create catkin workspace
mkdir -p catkin_ws/src
cd catkin_ws/src
git clone https://github.com/borisd13/home_service_robot
cd home_service_robot
git submodule init
git submodule update
cd ../..

# build catkin workspace
catkin_make