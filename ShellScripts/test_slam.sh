#!/bin/bash

CATKIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../.." >/dev/null && pwd )"

xterm  -e  " source $CATKIN_DIR/devel/setup.bash; roscore" & 
sleep 5
xterm  -e  " source $CATKIN_DIR/devel/setup.bash; roslaunch turtlebot_gazebo turtlebot_world.launch world_file:=$(rospack find wall_follower)/../World/ushape.world" &
sleep 5
xterm  -e  " source $CATKIN_DIR/devel/setup.bash; rosrun gmapping slam_gmapping" &
sleep 5
xterm  -e  " source $CATKIN_DIR/devel/setup.bash; roslaunch turtlebot_rviz_launchers view_navigation.launch" &
sleep 5
xterm  -e  " source $CATKIN_DIR/devel/setup.bash; roslaunch turtlebot_teleop keyboard_teleop.launch"