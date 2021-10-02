#!/bin/sh
# Script to build a test image (before pushing to git)

TAG=v1.0.2      # Stable Version 02.10.2021
NAME=ubuntu-python3

# Tag the image
docker tag jennerwein/${NAME}:test jennerwein/${NAME}:${TAG}
docker push jennerwein/${NAME}:${TAG}

docker tag jennerwein/${NAME}:test jennerwein/${NAME}:latest
docker push jennerwein/${NAME}:latest