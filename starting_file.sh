#!/bin/bash


clone_repo() {
        git clone $1 || {
                echo "Error: Failed to clone repository"
                return 1
        }
        cd docker-demo
}

install_requirements() {
        sudo apt-get update
        sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        sudo apt-get update
        sudo apt-get install -y docker-ce || {
                echo "Error: Failed to install docker."
                return 1
        }
}

deploy() {
        sudo docker build -t demo-app .
        sudo docker run -d -p 3000:3000 demo-app || {
                echo "Error: Failed to build container"
                return 1
        }
}

if ! clone_repo "https://github.com/surJ90/docker-demo.git"; then
        cd docker-demo || exit 1
fi

if ! install_requirements; then
        exit 1
fi

if ! deploy; then
        exit 1
fi