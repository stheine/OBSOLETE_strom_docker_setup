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
# Install and run stubby from https://github.com/getdnsapi/getdns.git

RUN \
  apk add \
    autoconf \
    automake \
    gcc \
    git \
    libtool \
    linux-headers \
    make \
    musl-dev \
    openssl-dev \
    yaml-dev && \
  git clone https://github.com/getdnsapi/getdns.git && \
  cd getdns && \
  git submodule update --init && \
  libtoolize -ci && \
  autoreconf -fi && \
  mkdir build && \
  cd build && \
  ../configure --prefix=/usr/local --without-libidn --without-libidn2 --enable-stub-only --with-stubby && \
  make && \
  make install

COPY stubby.yml /usr/local/etc/stubby/stubby.yml

COPY docker_container_profile /root/.profile
#EXPOSE 53
EXPOSE 6653

CMD ["/usr/local/bin/stubby"]
#CMD ["/bin/bash", "-l"]
