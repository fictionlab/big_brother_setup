#!/bin/bash -e
rm -rf /etc/ros/catkin_ws
mkdir -p -m 775 "/etc/ros/catkin_ws/src"


pushd /etc/ros/catkin_ws/src
# git clone https://github.com/fictionlab/big_brother.git
# git clone https://github.com/fictionlab/ipcamera_driver.git
install -v -m 664 packages/ipcamera_driver/* "/etc/ros/catkin_ws/src"
install -v -m 664 packages/leo_big_brother/* "/etc/ros/catkin_ws/src"

cd ..
catkin config --extend /opt/ros/melodic 
rosdep update
apt update
rosdep install --rosdistro melodic --from-paths src -iy --os=ubuntu:bionic
catkin build

popd

install -v -m 664 files/setup.bash "/etc/ros/"
install -v -m 664 files/robot.launch "/etc/ros/"
install -v -m 755 files/leo-start "/usr/bin/"
install -v -m 755 files/leo-stop "/usr/bin/"
install -v -m 644 files/leo.service "/etc/systemd/system/"

systemctl enable leo

