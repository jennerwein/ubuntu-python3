# Ubuntu with python3 (including pip3)
# 
FROM ubuntu:18.04

RUN apt-get update -y \
    && apt-get install -y vim \
    && apt-get install -y python3-pip \
    # delete cache and tmp files (from: vaeum/ubuntu-python3-pip3)
    # results in a more than 20MB smaller image
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/cache/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/lib/apt/lists/*

CMD [ "python3" ]