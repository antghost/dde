#!/bin/bash
[ -f "/usr/bin/docker" ] && echo 'Docker Installed' && exit

# 更换软件源
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak`date +%Y%m%d%H%M` \
  && sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# Update the apt
sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key:
curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Use the following command to set up the stable repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu \
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
sudo service docker start
echo 'Install Docker Done.'
