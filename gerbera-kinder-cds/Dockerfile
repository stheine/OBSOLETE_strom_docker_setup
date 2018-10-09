FROM resin/rpi-raspbian

# ##############################################################################
# Install all the base packages needed for the following installs
# Set up timezone

RUN \
  apt-get update && \
  apt-get install \
    vim \
    unzip \
    wget && \
  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
  echo "Europe/Berlin" > /etc/timezone

# ##############################################################################
# Install and run from https://github.com/gerbera/gerbera

RUN \
  apt-get install \
    apt-utils \
    autoconf \
    cmake \
    eclipse-cdt-autotools \
    g++ \
    gcc \
    git \
    libtool \
    make

RUN \
  apt-get install \
    uuid-dev \
    libexpat1-dev \
    libsqlite3-dev \
    libmysqlclient-dev \
    libmagic-dev \
    libexif-dev \
    libcurl4-openssl-dev \
    libavutil-dev \
    libavcodec-dev \
    libavformat-dev \
    libavdevice-dev \
    libavfilter-dev \
    libswscale-dev \
    libpostproc-dev \
    libavresample-dev

ARG CACHE_DATE=2018-10-06

# 1.2.0
#  wget https://github.com/gerbera/gerbera/archive/v1.2.0.zip && \
#  unzip v1.2.0.zip && \
#  mv gerbera-1.2.0 gerbera && \
# latest
#  git clone https://github.com/gerbera/gerbera.git && \

RUN \
  git clone https://github.com/gerbera/gerbera.git && \
  cat gerbera/scripts/install-pupnp18.sh  | sed "s/^\.\/bootstrap.*make install\\\\$/.\/bootstrap \&\& .\/configure \$extraFlags --enable-ipv6 --enable-reuseaddr \&\& make CFLAGS='-D_LARGE_FILE_SOURCE -D_FILE_OFFSET_BITS=64' LDFLAGS='-pthread -lpthread' \&\& sudo make install\\\\/" > /tmp/install-pupnp18.sh && \
  chmod 755 /tmp/install-pupnp18.sh && \
  mv /tmp/install-pupnp18.sh gerbera/scripts/install-pupnp18.sh && \
  mkdir build && \
  cd build && \
  sh ../gerbera/scripts/install-pupnp18.sh && \
  sh ../gerbera/scripts/install-duktape.sh && \
  bash ../gerbera/scripts/install-taglib111.sh && \
  cmake ../gerbera -DWITH_MAGIC=1 -DWITH_MYSQL=0 -DWITH_CURL=1 -DWITH_JS=1 -DWITH_TAGLIB=1 -DWITH_AVCODEC=1 -DWITH_EXIF=1 -DWITH_LASTFM=0 -DWITH_SYSTEMD=0 && \
  make -j4 && \
  sudo make install

COPY docker_container_profile /root/.profile
COPY config.xml /etc/gerbera/config.xml

# EXPOSE 1030/udp 1900/udp 9000/tcp
VOLUME /gerbera_config /mnt/nas_fritzbox
# /musik

ENTRYPOINT ["/usr/local/bin/gerbera", "-c", "/etc/gerbera/config.xml"]
# CMD ["/bin/bash", "-l"]
