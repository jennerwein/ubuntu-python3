# Ubuntu with python3

# https://hub.docker.com/_/ubuntu
FROM ubuntu:24.04

##### Auf Zeitzone und locale Europe/Berlin stellen #####################################
# https://serverfault.com/questions/683605/docker-container-time-timezone-will-not-reflect-changes
ENV DEBIAN_FRONTEND=noninteractive TZ=Europe/Berlin
ENV LANG=de_DE.UTF-8 LANGUAGE=de_DE:en

RUN apt-get update \
 && apt-get install -y --no-install-recommends tzdata locales \
 && echo "$TZ" > /etc/timezone \
 && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
 && sed -i 's/^# *de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen \
 && locale-gen \
 && update-locale LANG=de_DE.UTF-8 LANGUAGE=de_DE:en \
 && rm -rf /var/lib/apt/lists/*


##### Diverse Apps installieren ##############################################
# Tools + Python + PG-Client in einem Rutsch, sauber aufräumen
RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    vim \
    iproute2 \
    iputils-ping \
    curl \
    dnsutils \
    net-tools \
    redis-tools \
    python3-pip \
    python-is-python3 \
    python3-venv \
    gnupg \
    ca-certificates \
    lsb-release; \
  install -m 0755 -d /etc/apt/keyrings && \
  curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc -o /etc/apt/keyrings/pgdg.asc && \
  gpg --dearmor /etc/apt/keyrings/pgdg.asc && \
  mv /etc/apt/keyrings/pgdg.asc.gpg /etc/apt/keyrings/postgresql.gpg && \
  chmod 0644 /etc/apt/keyrings/postgresql.gpg && \
  # Ubuntu 24.04 = noble; alternativ: $(lsb_release -cs)
  echo "deb [signed-by=/etc/apt/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt noble-pgdg main" \
    > /etc/apt/sources.list.d/pgdg.list && \
  apt-get update && \
  apt-get install -y --no-install-recommends postgresql-client-18 && \
  rm -rf /var/lib/apt/lists/*

# Configure vim
RUN mkdir -p /root/.vim/colors
COPY vim/.vimrc /root/.vimrc
COPY vim/badwolf.vim /root/.vim/colors/badwolf.vim

##### Set environment variables ##############################################

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
# Markiere als Container
ENV CONTAINER=true    

##### Set alias ##############################################################
RUN cat <<'EOF' >> /root/.bashrc
alias c="clear"
alias h="history"
alias act=". /opt/venv/bin/activate"
alias st="python supertest.py"
alias st1="python supertest1.py"
alias st2="python supertest2.py"
alias cir="celery inspect registered"
alias cia="celery inspect active"
EOF

##### Activate virtual environment for Python ################################
# 
# https://pythonspeed.com/articles/activate-virtualenv-dockerfile

ENV VIRTUAL_ENV=/opt/venv
RUN set -eux && python3 -m venv "$VIRTUAL_ENV"
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Aktualisiere pip
RUN pip install --upgrade pip

##### BASISINSTALLATION ABGESCHLOSSEN #########################################

# Setzt das Arbeitsverzeichnis für die nachfolgenden Befehle
WORKDIR /app/code

# # Installation der Python-Requirements (ALS OPTION)
# COPY ./code/requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt


