#!/bin/bash

<< Comment
Simple script to deploy a node project
Comment

command_exists() {
        command -v "$1" >/dev/null 2>&1
}

log() {
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

if ! command_exists git; then
        echo "Error: git is not installed"
        echo "Installing git..."
        sudo apt-get update && sudo apt-get install -y git
        if [ $? -ne 0 ]; then
                log "Error: failed to install git"
                exit 1
        fi
fi

log "CLoning repo from GitHub..."
if [ -d "docker-demo" ]; then
        log "Repository already exists, pulling latest changes..."
        cd "docker-demo" || {
                log "Failed to cd into docker-demo"; exit 1;
        }
        git pull origin main
        if [ $? -ne 0 ]; then
                log "Error: Failed to pull changes..."
                exit 1;
        fi
else
        git clone https://github.com/surJ90/docker-demo.git
        if [ $? -ne 0 ]; then
                log "Error: failed to clone repo"
                exit 1;
        fi
        cd docker-demo || {
                log "Error: failed to cd to docker-demo"
        }
fi

if ! command_exists docker; then
        log "Docker not found, installing docker..."
        sudo apt-get update
        sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        sudo apt-get update
        sudo apt-get install -y docker-ce
        if [ $? -ne 0 ]; then
                log "Error; Failed to install Docker"
                exit 1
        fi

        sudo systemctl start docker
        sudo systemctl enable docker
fi

log "Building docker image"
sudo docker build -t demo-app .
sudo docker run -d --name demo-node-app -p 3000:3000 demo-app

log "container is running on port 3000"