#!/bin/bash

<< comment
Simple shell script to automate deploying a node project
comment

code_clone() {
        echo "Cloning node app..."
        if [ -d "docker-demo" ]; then
                echo "Code directory already exists!"
        else
                git clone https://github.com/surJ90/docker-demo.git || {
                        echo "Failed to clone repository!"
                        return 1
                }
        fi
}

install_requirements() {
        echo "Installing dependencies..."
        sudo apt-get update && sudo apt-get install -y docker.io || {
                echo "Failed to install dependencies!"
                return 1
        }
}

required_start() {
        echo "Performing required start..."
        sudo chown "$USER" /var/run/docker.sock || {
                echo "Failed to change ownership of docker.io"
                return 1
        }
}

deploy() {
        echo "Building and deploying the app..."
        docker build -t node-app . && docker run -d --name node-app -p 3000:3000 node-app || {
                echo "Failed to build and deploy"
                return 1
        }
}

if ! code_clone; then
        cd docker-demo || exit 1
fi

if ! install_requirements; then
        exit 1
fi

if ! required_restart; then
        exit 1
fi

if ! deploy; then
        echo "Deployment failed!"
        exit 1
fi