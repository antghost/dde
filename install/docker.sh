#!/bin/bash
[ -f "/usr/bin/docker" ] && echo 'Docker Installed' && exit

# https://docs.docker.com/engine/install/ubuntu/
# Update the apt
sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key:
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
if [ ! -f "/etc/apt/keyrings/docker.gpg" ]; then
    echo 'Error: Add Docker GPG key failed.'
    exit
fi
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Use the following command to set up the stable repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# 镜像加速
sudo mkdir -p /etc/docker
echo \
  "{
    \"dns\": [\"8.8.8.8\", \"223.5.5.5\", \"114.114.114.114\"]
}" | sudo tee /etc/docker/daemon.json > /dev/null

# Start docker
if [ -f "/usr/bin/docker" ]; then
    sudo service docker start
    echo 'Install Docker Done.'
else
    echo 'Error: Install Docker failed.'
fi
