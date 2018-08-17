FROM arm32v6/alpine:latest

# ##############################################################################
# Install all the base packages needed for the following installs
# Set up timezone

RUN apk update && \
  apk add \
    bash \
    ca-certificates \
    tzdata \
    wget && \
  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
  echo "Europe/Berlin" > /etc/timezone && \
  apk del tzdata

# ##############################################################################
# Install and run serviio from https://sourceforge.net/projects/minidlna/files/minidlna/ 

ENV VERSION 1.2.1

RUN \
  apk add \
    autoconf \
    automake \
    bsd-compat-headers \
    ffmpeg-dev \
    flac-dev \
    gcc \
    gettext-dev \
    git \
    libexif-dev \
    libid3tag-dev \
    libjpeg-turbo-dev \
    libvorbis-dev \
    make \
    musl-dev \
    sqlite-dev

RUN \
  git clone https://git.code.sf.net/p/minidlna/git minidlna && \
  cd /minidlna && \
  ./autogen.sh && \
  ./configure && \
  make

# serviio requires TCP port 8895 and UDP 1900 for content
# and 8200 for console
EXPOSE 1900/udp 8895/tcp 8200

VOLUME /musik /nas_fritzbox /serviio/log /serviio/library /serviio/transcode

COPY docker_container_profile /root/.profile
COPY minidlna.conf /minidlna/

ENTRYPOINT ["/minidlna/minidlnad", "-d", "-L", "-f", "/minidlna/minidlna.conf"]
# CMD ["/bin/bash", "-l"]
