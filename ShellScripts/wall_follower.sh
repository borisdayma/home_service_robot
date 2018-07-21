#!/bin/sh
xterm  -e  " source $HOME/catkin_ws/devel/setup.bash; roscore" & 
sleep 5
xterm  -e  " source $HOME/catkin_ws/devel/setup.bash; roslaunch turtlebot_gazebo turtlebot_world.launch world_file:=$HOME/catkin_ws/src/World/ushape.world" &
sleep 5
xterm  -e  " source $HOME/catkin_ws/devel/setup.bash; rosrun gmapping slam_gmapping" &
sleep 5
xterm  -e  " source $HOME/catkin_ws/devel/setup.bash; roslaunch turtlebot_rviz_launchers view_navigation.launch" &
sleep 5
xterm  -e  " source $HOME/catkin_ws/devel/setup.bash; rosrun wall_follower wall_follower_node"