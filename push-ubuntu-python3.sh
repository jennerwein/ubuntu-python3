#!/bin/sh
# Script to build a test image (before pushing to git)

# TAG=v1.0.4      # Stable Version 06.01.2022 (Ubuntu 20.04)
# TAG=v1.1        # Stable Version 17.05.2022 (Ubuntu 22.04)
# TAG=v1.1.1      # Stable Version 27.06.2022 (update)
TAG=v1.1.2      # Stable Version 01.10.2022 (update)
NAME=ubuntu-python3

# Tag the image
docker tag jennerwein/${NAME}:test jennerwein/${NAME}:${TAG}
docker push jennerwein/${NAME}:${TAG}

docker tag jennerwein/${NAME}:test jennerwein/${NAME}:latest
docker push jennerwein/${NAME}:latest
