# Ubuntu with python3 (including pip3)
# Maintainer: martin.leischner@h-brs.de
# Change 25.07.2021 (v1.0.2): net-tools added
# Change 15.12.2021 (v1.0.3): Update
# Change 06.01.2022 (v1.0.4, python 3.8.10): Update + python-is-python3
# Change 17.05.2022 (v1.1, python 3.10.4): Ubuntu 22.04
# Change 27.06.2022 (v1.1.1, python 3.10.4): Update
# Change 01.10.2022 (v1.1.2, python 3.10.6): Update
# Change 02.10.2022 (v1.2, python 3.10.6): vim configured
# Change 02.10.2022 (v1.2.1, python 3.10.6): Update
# Change 17.11.2022 (v1.2.2, python 3.10.6): PYTHONUNBUFFERED=1 +alias+wheel
# Change 04.05.2023 (v1.2.3, python 3.10.6): Update
# Change 27.05.2023 (v1.2.4, python 3.10.6): Update, Alias
# Change 29.05.2023 (v1.2.6, python 3.10.6): Update, ENV optimiert
# Change 20.06.2024 (v1.3, python 3.12.3): Ubuntu 24.04
# Change 21.06.2024 (v1.4, python 3.12.3): Python in virtEnv /opt/venv/
# Change 21.06.2024 (v1.4.1, python 3.12.3): ENV CONTAINER=true

# https://hub.docker.com/_/ubuntu
FROM ubuntu:24.04

# https://serverfault.com/questions/683605/docker-container-time-timezone-will-not-reflect-changes
ENV TZ=Europe/Berlin
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PIP_DISABLE_PIP_VERSION_CHECK=1

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
    && apt-get install -y postgresql-client \
    && apt-get install -y sqlite3 \
    && apt-get install -y redis-tools \
    && apt-get install -y locales \
    && apt-get install -y python3-pip \
    && apt-get install -y python-is-python3 \
    && apt-get install -y python3.12-venv \
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

# Configure vim
COPY vim/.vimrc /root/.vimrc
COPY vim/badwolf.vim /root/.vim/colors/badwolf.vim

# Set alias
RUN echo 'alias c="clear"' >> ~/.bashrc                      \
&& echo 'alias h="history"' >> ~/.bashrc                     \
&& echo 'alias act=". venv/bin/activate"' >> ~/.bashrc       \
&& echo 'alias st="python supertest.py"' >> ~/.bashrc        \
&& echo 'alias st1="python supertest1.py"' >> ~/.bashrc      \
&& echo 'alias st2="python supertest2.py"' >> ~/.bashrc      \
&& echo 'alias cir="celery inspect registered"' >> ~/.bashrc \
&& echo 'alias cia="celery inspect active"' >> ~/.bashrc

# Markiere als Container
ENV CONTAINER=true

############################################################
# Activate virtual environment for Python
# https://pythonspeed.com/articles/activate-virtualenv-dockerfile

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Aktualisiere pip
RUN pip install --upgrade pip

############################################################

# Setzt das Arbeitsverzeichnis für die nachfolgenden Befehle
WORKDIR /app/code

# # Installation der Python-Requirements (ALS OPTION)
# COPY ./code/requirements.txt .
# # install requirements for the app trapp
# RUN pip3 install -r requirements.txt 

EXPOSE 8000

# # Commented it out if you want to start plain ubuntu
# CMD [ "python3" ]
