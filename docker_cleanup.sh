#!/bin/bash
# docker_cleanup.sh - Cleans up unused Docker containers, images, and volumes
# Usage: ./docker_cleanup.sh

if ! command -v docker &> /dev/null; then
    echo "Docker not found. Please install Docker first."
    exit 1
fi

echo "Stopping unused containers..."
docker container prune -f
echo "Removing unused images..."
docker image prune -a -f
echo "Removing unused volumes..."
docker volume prune -f
echo "Docker cleanup complete." 