FROM debian:jessie
MAINTAINER OKUMURA Takahiro <hfm.garden@gmail.com>

ENV PHPIZE_DEPS \
      autoconf \
      file \
      g++ \
      gcc \
      libc-dev \
      make \
      pkg-config \
      re2c

RUN apt-get update && apt-get install -y \
      $PHPIZE_DEPS \
      ca-certificates \
      curl \
      libedit2 \
      libsqlite3-0 \
      libxml2 \
      xz-utils \
      git \
      --no-install-recommends && rm -r /var/lib/apt/lists/*

RUN git clone --depth 1 git://github.com/php-build/php-build.git \
      && sh /php-build/install.sh && rm -rf /php-build
