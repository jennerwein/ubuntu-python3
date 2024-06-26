#!/bin/sh
# Script to push image with right tags to git
# https://hub.docker.com/r/jennerwein/ubuntu-python3

# TAG=v1.0.4      # Stable Version 06.01.2022 (Ubuntu 20.04)
# TAG=v1.1        # Stable Version 17.05.2022 (Ubuntu 22.04)
# TAG=v1.1.1      # Stable Version 27.06.2022 (update)
# TAG=v1.1.2      # Stable Version 01.10.2022 (update)
# TAG=v1.2        # Stable Version 02.10.2022 (vim configured)
# TAG=v1.2.1      # Stable Version 27.10.2022 (update)
# TAG=v1.2.2      # Stable Version 17.11.2022 (alias+wheel)
# TAG=v1.2.3      # Stable Version 04.05.2023 (update)
# TAG=v1.2.4      # Stable Version 27.05.2023 (update, alias)
# TAG=v1.2.5      # Stable Version 29.05.2023 (update, ENV)
# TAG=v1.2.6      # Stable Version 26.10.2023 (update)
# TAG=v1.2.7      # Stable Version 19.12.2023 (update)
# TAG=v1.2.7      # Stable Version 19.12.2023 (update)
# TAG=v1.3        # Stable Version 21.06.2024 (Ubuntu 24.04)
# TAG=v1.4        # Stable Version 21.06.2024 (Python in virtEnv /opt/venv/)
# TAG=v1.4.1        # Stable Version 21.06.2024 (ENV CONTAINER=true)

TAG=v1.4.2          # Stable Version 21.06.2024 (Vorbereitung Inst. requirements)

NAME=ubuntu-python3

# Tag the image
docker tag jennerwein/${NAME}:test jennerwein/${NAME}:${TAG}
docker push jennerwein/${NAME}:${TAG}

docker tag jennerwein/${NAME}:test jennerwein/${NAME}:latest
docker push jennerwein/${NAME}:latest
