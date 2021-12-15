# Ubuntu with python3 (including pip3)
# Maintainer: martin.leischner@h-brs.de
# Change 25.07.2021 (v1.0.2): net-tools added
# Change 15.12.2021 (v1.0.3): Update

FROM ubuntu:20.04

# https://serverfault.com/questions/683605/docker-container-time-timezone-will-not-reflect-changes
ENV TZ=Europe/Berlin

RUN apt-get update -y \
    && apt-get upgrade -y \
    # Setting time zone
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt-get install -y tzdata \
    && apt-get install -y vim \
    && apt-get install -y iproute2 \
    && apt-get install -y iputils-ping \
    && apt-get install -y curl \
    && apt-get install -y dnsutils \
    && apt-get install -y net-tools \
    && apt-get install -y locales \
    && apt-get install -y python3-pip \
    # delete cache and tmp files (from: vaeum/ubuntu-python3-pip3)
    # results in a more than 20MB smaller image
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/cache/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/lib/apt/lists/*

# Set the locale
# https://stackoverflow.com/questions/28405902/how-to-set-the-locale-inside-a-debian-ubuntu-docker-container
# RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
#     locale-gen
# ENV LANG en_US.UTF-8  
# ENV LANGUAGE en_US:en  
# ENV LC_ALL en_US.UTF-8 

RUN sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG de_DE.UTF-8  
ENV LANGUAGE de_DE:en  
ENV LC_ALL de_DE.UTF-8 

# # Commented it out if you want to start plain ubuntu
# CMD [ "python3" ]