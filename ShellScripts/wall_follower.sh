#!/bin/sh

# Setup DIR to home directory if necessary (useful for Udacity workspace)
DIR=$HOME

xterm  -e  " source $DIR/catkin_ws/devel/setup.bash; roscore" & 
sleep 5
xterm  -e  " source $DIR/catkin_ws/devel/setup.bash; roslaunch turtlebot_gazebo turtlebot_world.launch world_file:=$DIR/catkin_ws/src/home_service_robot/World/ushape.world" &
sleep 5
xterm  -e  " source $DIR/catkin_ws/devel/setup.bash; rosservice call /gazebo/set_model_state '{model_state: { model_name: mobile_base, pose: { position: { x: -3.1, y: 7.9 ,z: 0 }}} }'" &
sleep 30  # give enough time to manually adjust orientation
xterm  -e  " source $DIR/catkin_ws/devel/setup.bash; rosrun gmapping slam_gmapping _linearUpdate:=0.1 _angularUpdate:=0.1 _particles:=30 _xmin:=-20 _ymin:=-20 _xmax:=20 _ymax:=20 _map_update_interval:=0.5 _lskip:=1 _delta:=0.05 _minimumScore:=200 _maxUrange:=50" &
sleep 5
xterm  -e  " source $DIR/catkin_ws/devel/setup.bash; roslaunch turtlebot_rviz_launchers view_navigation.launch" &
sleep 5
xterm  -e  " source $DIR/catkin_ws/devel/setup.bash; rosrun wall_follower wall_follower_node"