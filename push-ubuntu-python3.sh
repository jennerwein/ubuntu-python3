#!/bin/sh
# Script to build a test image (before pushing to git)

TAG=v1.0.1      # Stable Version 27.07.21
NAME=ubuntu-python3

# Tag the image
docker tag jennerwein/${NAME}:test jennerwein/${NAME}:${TAG}
docker push jennerwein/${NAME}:${TAG}

