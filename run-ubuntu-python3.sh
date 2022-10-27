#!/bin/sh
# Run the test image for testing. The test container is deleted by exit.

docker run --name ubuntu-python3 --rm -it jennerwein/ubuntu-python3:test