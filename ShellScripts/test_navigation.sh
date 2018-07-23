#!/bin/sh

# Setup DIR to home directory if necessary (useful for Udacity workspace)
DIR=$HOME

xterm  -e  " source $DIR/catkin_ws/devel/setup.bash; roscore" & 
sleep 5
xterm  -e  " source $DIR/catkin_ws/devel/setup.bash; roslaunch turtlebot_gazebo turtlebot_world.launch world_file:=$DIR/catkin_ws/src/home_service_robot/World/ushape.world" &
sleep 5
xterm  -e  " source $DIR/catkin_ws/devel/setup.bash; rosservice call /gazebo/set_model_state '{model_state: { model_name: mobile_base, pose: { position: { x: -2.7, y: 7.3 ,z: 0 }, orientation: {x: 0, y: 0, z: -0.676, w: 0.737}}}}'" &
sleep 5
xterm  -e  " source $DIR/catkin_ws/devel/setup.bash; roslaunch turtlebot_gazebo amcl_demo.launch map_file:=$DIR/catkin_ws/src/home_service_robot/World/my_map.yaml" &
sleep 5
xterm  -e  " source $DIR/catkin_ws/devel/setup.bash; roslaunch turtlebot_rviz_launchers view_navigation.launch" &