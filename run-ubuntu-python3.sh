#!/bin/sh
# Image zum Testen laufen lassen. Nach exit wird Container gelöscht.

docker run --name ubuntu-python3 --rm -it jennerwein/ubuntu-python3:test