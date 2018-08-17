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
# Install dcraw

RUN \
  apk add \
    gcc \
    jasper-dev \
    lcms2-dev \
    libjpeg-turbo-dev \
    musl-dev

WORKDIR /dcraw

RUN \
  wget http://www.cybercom.net/~dcoffin/dcraw/dcraw.c && \
  gcc -o dcraw -O4 dcraw.c -lm -ljasper -ljpeg -llcms2 && \
  chmod +x dcraw && \
  cp dcraw /usr/bin/dcraw

# ##############################################################################
# Install and run serviio from http://serviio.org/download

RUN \
  apk add \
    ffmpeg \
    libraw \
    openjdk8-jre

ENV SERVIIO_VERSION 1.9.2

RUN \
  wget http://download.serviio.org/releases/serviio-${SERVIIO_VERSION}-linux.tar.gz && \
  tar xf serviio-${SERVIIO_VERSION}-linux.tar.gz && \
  mv serviio-${SERVIIO_VERSION} /serviio && \
  rm serviio-${SERVIIO_VERSION}-linux.tar.gz

WORKDIR /serviio

RUN \
  cat bin/serviio.sh | sed -e 's/-Xmx512M/-Xmx1024M/' > bin/serviio.sh.tmp && \
  mv bin/serviio.sh.tmp bin/serviio.sh && \
  chmod 755 bin/serviio.sh

# serviio requires TCP port 8895 and UDP 1900 for content and
# 23423 (console) and 23424 (API & mediabrowser) api
EXPOSE 1900/udp 8895/tcp 23423 23424

VOLUME /musik /nas_fritzbox /serviio/log /serviio/library /serviio/transcode

COPY docker_container_profile /root/.profile

ENTRYPOINT ["bin/serviio.sh"]
# CMD ["/bin/bash", "-l"]
