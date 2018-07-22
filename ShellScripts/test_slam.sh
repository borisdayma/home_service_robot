#!/bin/sh

# Setup DIR to home directory if necessary (useful for Udacity workspace)
DIR=$HOME

xterm  -e  " source $DIR/catkin_ws/devel/setup.bash; roscore" & 
sleep 5
xterm  -e  " source $DIR/catkin_ws/devel/setup.bash; roslaunch turtlebot_gazebo turtlebot_world.launch world_file:=$DIR/catkin_ws/src/home_service_robot/World/ushape.world" &
sleep 5
xterm  -e  " source $DIR/catkin_ws/devel/setup.bash; rosrun gmapping slam_gmapping" &
sleep 5
xterm  -e  " source $DIR/catkin_ws/devel/setup.bash; roslaunch turtlebot_rviz_launchers view_navigation.launch" &
sleep 5
xterm  -e  " source $DIR/catkin_ws/devel/setup.bash; roslaunch turtlebot_teleop keyboard_teleop.launch"