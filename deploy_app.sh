#!/bin/bash
# deploy_app.sh - Deploys an application from a Git repository
# Usage: ./deploy_app.sh
# Edit REPO_URL, BRANCH, and DEPLOY_DIR as needed.

REPO_URL="https://github.com/example/app.git"
BRANCH="main"
DEPLOY_DIR="/var/www/app"

if [ ! -d "$DEPLOY_DIR" ]; then
    git clone -b "$BRANCH" "$REPO_URL" "$DEPLOY_DIR"
else
    cd "$DEPLOY_DIR"
    git pull origin "$BRANCH"
fi

echo "Application deployed to $DEPLOY_DIR." 