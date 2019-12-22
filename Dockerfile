# Ubuntu with python3 (including pip3)
# 
FROM ubuntu:18.04

LABEL version="0.9.0"

RUN apt-get update -y \
    && apt-get install -y python3-pip

CMD [ "python3" ]