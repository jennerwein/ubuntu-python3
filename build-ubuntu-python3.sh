#!/bin/sh
# Script to build a test image.(Use it before pushing to git)

TAG=test
NAME=ubuntu-python3

# Build the image
docker rmi jennerwein/${NAME}:${TAG}
docker build -t jennerwein/${NAME}:${TAG} .

