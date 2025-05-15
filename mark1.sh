#!/bin/bash

<< comment
basic code for automation without any fault checks
comment

git clone https://github.com/surJ90/docker-demo.git
cd docker-demo
sudo apt-get update 
sudo apt-get install -y docker.io
sudo docker build -t demo-app .
sudo docker run -d --name demo-node-app -p 3000:3000 demo-app

echo "App is running!"