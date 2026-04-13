#!/bin/bash
set -e
#check if docker and docker-compose are installed

docker version || {
    echo "Docker could not be found. Please install Docker to proceed."
    exit 1
}
docker compose version || {
    echo "Docker Compose could not be found. Please install Docker Compose to proceed."
    exit 1
}