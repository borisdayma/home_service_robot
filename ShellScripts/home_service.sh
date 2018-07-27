#!/bin/bash

CATKIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../.." >/dev/null && pwd )"

source $CATKIN_DIR/devel/setup.bash

xterm  -e  " source $CATKIN_DIR/devel/setup.bash; roscore" & 
sleep 5
xterm  -e  " source $CATKIN_DIR/devel/setup.bash; roslaunch turtlebot_gazebo turtlebot_world.launch world_file:=$(rospack find wall_follower)/../World/ushape.world" &
sleep 5
xterm  -e  " source $CATKIN_DIR/devel/setup.bash; rosservice call /gazebo/set_model_state '{model_state: { model_name: mobile_base, pose: { position: { x: -2.7, y: 7.3 ,z: 0 }, orientation: {x: 0, y: 0, z: -0.676, w: 0.737}}}}'" &
sleep 5
xterm  -e  " source $CATKIN_DIR/devel/setup.bash; roslaunch turtlebot_gazebo amcl_demo.launch map_file:=$(rospack find wall_follower)/../World/my_map.yaml" &
sleep 5
xterm  -e  " source $CATKIN_DIR/devel/setup.bash; rosrun rviz rviz -d $(rospack find wall_follower)/../rviz/config.rviz" &
sleep 5
xterm  -e  " source $CATKIN_DIR/devel/setup.bash; rosrun add_markers add_markers_node" &
sleep 5
xterm  -e  " source $CATKIN_DIR/devel/setup.bash; rosrun pick_objects pick_objects_node" &