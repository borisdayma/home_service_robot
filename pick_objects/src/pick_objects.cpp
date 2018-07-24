#include <ros/ros.h>
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>
#include "std_msgs/String.h"

// Define a client for to send goal requests to the move_base server through a SimpleActionClient
typedef actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> MoveBaseClient;

// Define a publisher to communicate when reaching pick-up and drop-off locations
ros::Publisher target_pub;

int main(int argc, char** argv){
  // Initialize the pick_objects node
  ros::init(argc, argv, "pick_objects");
  ros::NodeHandle n;

  // Initialize publisher
  target_pub = n.advertise<std_msgs::String>("target_msg", 10);

  // tell the action client that we want to spin a thread by default
  MoveBaseClient ac("move_base", true);

  // Wait 5 sec for move_base action server to come up
  while(!ac.waitForServer(ros::Duration(5.0))){
    ROS_INFO("Waiting for the move_base action server to come up");
  }

  move_base_msgs::MoveBaseGoal goal_1, goal_2;
  std_msgs::String msg;

  // set up the frame parameters
  goal_1.target_pose.header.frame_id = "map";
  goal_1.target_pose.header.stamp = ros::Time::now();

  // Define a position and orientation for the robot to reach
  goal_1.target_pose.pose.position.x = 7.6;
  goal_1.target_pose.pose.position.y = 1.1;
  goal_1.target_pose.pose.orientation.z = 0.67;
  goal_1.target_pose.pose.orientation.w = 0.74;

   // Send the goal position and orientation for the robot to reach
  ROS_INFO("Sending pick-up location");
  ac.sendGoal(goal_1);

  // Wait an infinite time for the results
  ac.waitForResult();

  // Check if the robot reached its goal
  if(ac.getState() == actionlib::SimpleClientGoalState::SUCCEEDED)
  {
    ROS_INFO("Reached pick-up location! Picking up object...");
    msg.data = "pick-up";
    target_pub.publish(msg);
  }
  else
  {
    ROS_INFO("Failed to reach pick-up location");
    return 0;
  }

  // Wait for 5 seconds
  while(!ac.waitForServer(ros::Duration(5.0))){
    ROS_INFO("Still picking up object...");
  }

  // Define drop off location

  // set up the frame parameters
  goal_2.target_pose.header.frame_id = "map";
  goal_2.target_pose.header.stamp = ros::Time::now();

  // Define a position and orientation for the robot to reach
  goal_2.target_pose.pose.position.x = 1.6;
  goal_2.target_pose.pose.position.y = 7.6;
  goal_2.target_pose.pose.orientation.z = 1.0;
  goal_2.target_pose.pose.orientation.w = 0.;

   // Send the goal position and orientation for the robot to reach
  ROS_INFO("Sending drop-off location");
  ac.sendGoal(goal_2);

  // Wait an infinite time for the results
  ac.waitForResult();

  // Check if the robot reached its goal
  if(ac.getState() == actionlib::SimpleClientGoalState::SUCCEEDED)
  {
    ROS_INFO("Reached drop-off location!");
    msg.data = "drop-off";
    target_pub.publish(msg);
  }
  else
    ROS_INFO("Failed to reach drop-off location");

  return 0;
}