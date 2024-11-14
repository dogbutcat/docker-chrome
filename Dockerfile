FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

RUN apt-get update; apt-get clean

RUN apt-get install -y wget

# Add CN lang support
RUN apt-get install -y locales systemd fonts-noto-cjk

# Install gnupg
RUN apt-get install -y gnupg

# Set the Chrome repo.
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Install Chrome.
RUN apt-get update && apt-get -y install google-chrome-stable

RUN rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

COPY /root /

ENV LC_ALL=zh_CN.UTF-8
ENV CHROME_VER=127.0.6533.99

VOLUME /config