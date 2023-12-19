# ubuntu-python3

Ubuntu image 22.04 with python including pip3. Also with iproute2, curl and other tools. The image is localized for german.

A docker image should be as small as possible satisfying all dependencies. No easy task. My straightforward solution:  
`ubuntu:22.04` + `python3-pip` = `ubuntu-python3:latest`
