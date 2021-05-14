#!/bin/sh
# Script to build a test image (before pushing to git)

TAG=v1.0.0      # Stable Version 14.05.21
NAME=ubuntu-python3

# Tag the image
docker tag jennerwein/${NAME}:test jennerwein/${NAME}:${TAG}
docker push jennerwein/${NAME}:${TAG}

