# ubunutu-python3
Ubuntu image with python3 including pip3

A docker image should be as small as possible and satisfy all dependencies. No easy task, as you can see here: <https://pythonspeed.com/articles/base-image-python-docker-images/>. My straightforward solution after some trial and error: `ubuntu:18.04` + `python3-pip` = `ubuntu-python3:18.04`

Checking the github I found that I was not the first with this 'brilliant' idea.
