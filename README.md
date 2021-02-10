# ubuntu-python3

Ubuntu image 20.04 with python3 including pip3. Also with iproute2 and curl. The image is localized for german.

A docker image should be as small as possible and satisfy all dependencies. No easy task, as you can see here: <https://pythonspeed.com/articles/base-image-python-docker-images/>. My straightforward solution after some trial and error: `ubuntu:20.04` + `python3-pip` = `ubuntu-python3:latest`

Checking the github I found that I was not the first with this 'brilliant' idea.
