#!/bin/bash
set -e

IMAGE_NAME=frontend-base:ubuntu
DOCKER_REGISTRY=<your address>/$IMAGE_NAME

echo "dokcer build $IMAGE_NAME"
docker build -t $IMAGE_NAME .

echo "docker tag to $DOCKER_REGISTRY"
docker tag $IMAGE_NAME $DOCKER_REGISTRY

echo "docker push $DOCKER_REGISTRY"
docker push $DOCKER_REGISTRY

echo "Finished"

set +e
