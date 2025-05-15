#!/bin/bash

REPO_URL="https://github.com/surJ90/docker-demo.git"
CLONE_DIR="/home/ubuntu/docker-demo"
BRANCH="main"

initiate_docker() {
    if command -v docker >/dev/null 2>&1; then
        echo "Docker already installed"
    else
        echo "Installing Docker..."
        sudo apt-get update
        sudo apt-get install -y apt-transport-https ca-certificates curl
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        sudo apt-get update
        sudo apt-get install -y docker-ce || { echo "Docker install failed"; exit 1; }
        sudo usermod -aG docker "$USER"
    fi
}

pull_code() {
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1 && \
       git remote get-url origin | grep -q "$REPO_URL"; then
        echo "In repo, pulling $BRANCH..."
        git fetch origin "$BRANCH" || { echo "Fetch failed"; exit 1; }
        if git diff --quiet HEAD "origin/$BRANCH"; then
            echo "No new changes"
        else
            git pull origin "$BRANCH" || { echo "Pull failed, resolve conflicts manually"; exit 1; }
            echo "Pulled latest changes"
        fi
    elif [ -d "$CLONE_DIR/.git" ]; then
        echo "Repo exists at $CLONE_DIR, pulling $BRANCH..."
        cd "$CLONE_DIR" || { echo "Cannot cd"; exit 1; }
        git fetch origin "$BRANCH" || { echo "Fetch failed"; exit 1; }
        if git diff --quiet HEAD "origin/$BRANCH"; then
            echo "No new changes"
        else
            git pull origin "$BRANCH" || { echo "Pull failed, resolve conflicts manually"; exit 1; }
            echo "Pulled latest changes"
        fi
    else
        echo "Cloning $REPO_URL to $CLONE_DIR..."
        git clone --branch "$BRANCH" "$REPO_URL" "$CLONE_DIR" || { echo "Clone failed"; exit 1; }
        cd "$CLONE_DIR" || { echo "Cannot cd"; exit 1; }
        echo "Cloned repository"
    fi
}

deploy() {
    echo "Checking deployment status..."
    if sudo docker image inspect demo-app >/dev/null 2>&1; then
        if sudo docker ps -q -f name=demo-app >/dev/null; then
            echo "Container already running"
            return 0
        else
            echo "Image exists, running container..."
            sudo docker run -d --name demo-app -p 3000:3000 demo-app || {
                echo "Failed to run container"; exit 1;
            }
        fi
    else
        echo "Building and running container..."
        sudo docker build -t demo-app . && sudo docker run -d --name demo-app -p 3000:3000 demo-app || {
            echo "Failed to build or run container"; exit 1;
        }
    fi
}

command -v git >/dev/null 2>&1 || { echo "Git not installed"; exit 1; }
initiate_docker
pull_code
deploy
echo "*********** APP RUNNING SUCCESSFULLY *************"