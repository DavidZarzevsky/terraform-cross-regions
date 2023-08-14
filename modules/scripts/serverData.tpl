#!/bin/bash

# Update and install prerequisites
sudo apt-get update -y &&
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common

# Add Docker repository and install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y &&
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# Add user to Docker group
sudo usermod -aG docker ubuntu

#Install Apache HTTP server
sudo apt-get install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2

# Install stress
sudo apt-get install stress

# Install git
sudo apt-get install git



