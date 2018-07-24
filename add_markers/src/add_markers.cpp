#include <ros/ros.h>
#include <visualization_msgs/Marker.h>
#include "std_msgs/String.h"

// Define a subscriber to receive messages when reaching pick-up and drop-off locations
ros::Subscriber target_sub;

// Define a publisher for markers on rviz
ros::Publisher marker_pub;

// Define the marker to publish
visualization_msgs::Marker marker;

// Callback when a message is received
void target_callback(const std_msgs::String::ConstPtr& msg)
{
  ROS_INFO("Received message: [%s]", msg->data.c_str());

  if (msg->data == "pick-up")
  {
    // Object has been picked up and we need to hide it
    marker.action = visualization_msgs::Marker::DELETE;
    marker_pub.publish(marker);
  }
  if (msg->data == "drop-off")
  {
    // Object can be displayed at drop-off location
    marker.action = visualization_msgs::Marker::ADD;
    // TODO target locations should be passed by other node or as parameters
    marker.pose.position.x = 1.6;
    marker.pose.position.y = 7.6;
    marker.pose.orientation.z = 1.;
    marker.pose.orientation.w = 0.74;
    marker_pub.publish(marker);
  }
}

int main( int argc, char** argv )
{
  ros::init(argc, argv, "add_markers");
  ros::NodeHandle n;
  ros::Rate r(1);
  marker_pub = n.advertise<visualization_msgs::Marker>("visualization_marker", 1);
  target_sub = n.subscribe("target_msg", 10, target_callback);

  // Set our shape type to be a cube
  uint32_t shape = visualization_msgs::Marker::CUBE;

  while (ros::ok())
  {
    
    // Set the frame ID and timestamp.  See the TF tutorials for information on these.
    marker.header.frame_id = "map";
    marker.header.stamp = ros::Time::now();

    // Set the namespace and id for this marker.  This serves to create a unique ID
    // Any marker sent with the same namespace and id will overwrite the old one
    marker.ns = "basic_shapes";
    marker.id = 0;

    // Set the marker type.  Initially this is CUBE, and cycles between that and SPHERE, ARROW, and CYLINDER
    marker.type = shape;

    // Set the marker action.  Options are ADD, DELETE, and new in ROS Indigo: 3 (DELETEALL)
    marker.action = visualization_msgs::Marker::ADD;

    // Set the pose of the marker.  This is a full 6DOF pose relative to the frame/time specified in the header
    // TODO target locations should be passed by other node or as parameters
    marker.pose.position.x = 7.6;
    marker.pose.position.y = 1.1;
    marker.pose.orientation.z = 0.67;
    marker.pose.orientation.w = 0.74;

    // Set the scale of the marker -- 1x1x1 here means 1m on a side
    marker.scale.x = 0.5;
    marker.scale.y = 0.5;
    marker.scale.z = 0.5;

    // Set the color -- be sure to set alpha to something non-zero!
    marker.color.r = 0.0f;
    marker.color.g = 1.0f;
    marker.color.b = 0.0f;
    marker.color.a = 1.0;

    marker.lifetime = ros::Duration();

    // Publish the marker
    while (marker_pub.getNumSubscribers() < 1)
    {
      if (!ros::ok())
      {
        return 0;
      }
      ROS_WARN_ONCE("Please create a subscriber to the marker");
      sleep(1);
    }
    marker_pub.publish(marker);

    // Spin to wait for messages (reaching target locations)
    ros::spin();
  }
}