# credits to @pokurt
FROM python:3.9.13-slim-buster

ENV PIP_NO_CACHE_DIR 1

RUN sed -i.bak 's/us-west-2\.ec2\.//' /etc/apt/sources.list
# RUN mkdir /tmp
RUN chmod 777 /tmp
# Installing Required Packages
RUN apt update && apt upgrade -y && \
    apt install --no-install-recommends -y \
    debian-keyring \
    debian-archive-keyring \
    bash \
    bzip2 \
    curl \
    figlet \
    git \
    util-linux \
    libffi-dev \
    libjpeg-dev \
    libjpeg62-turbo-dev \
    libwebp-dev \
    linux-headers-arm64 \
    musl-dev \
    musl \
    neofetch \
    php-pgsql \
    python3-lxml \
    postgresql \
    postgresql-client \
    python3-psycopg2 \
    libpq-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libxslt1-dev \
    python3-pip \
    python3-requests \
    python3-sqlalchemy \
    python3-tz \
    python3-aiohttp \
    openssl \
    pv \
    jq \
    wget \
    python3 \
    python3-dev \
    libreadline-dev \
    libyaml-dev \
    gcc \
    sqlite3 \
    libsqlite3-dev \
    sudo \
    zlib1g \
    ffmpeg \
    libssl-dev \
    libgconf-2-4 \
    libxi6 \
    xvfb \
    unzip \
    libopus0 \
    libopus-dev \
    libmagickwand-dev \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp

RUN curl https://cli-assets.heroku.com/install.sh

RUN python3 -m ensurepip \
    && pip3 install --upgrade pip setuptools \
    && ln -s pip3 /usr/bin/pip \
    && ln -sf /usr/bin/python3 /usr/bin/python

#
# Clone repo and prepare working directory
#

RUN git clone https://github.com/TgCatUB/catuserbot.git /root/userbot
RUN mkdir /root/userbot/.bin
ENV PATH="/home/userbot/bin:$PATH"
WORKDIR /root/userbot/
RUN ls && mv sample_config.py config.py

#
# Install requirements
#
RUN pip3 install -r requirements.txt
RUN pip3 install emoji==1.7
CMD ["python3","-m","userbot"]