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

RUN apt-get -qq update && apt-get -qq install -y \
      $PHPIZE_DEPS \
      ca-certificates \
      curl \
      libedit2 \
      libsqlite3-0 \
      libxml2 \
      xz-utils \
      git \
      bzip2 \
      libcurl4-openssl-dev \
      libedit-dev \
      libsqlite3-dev \
      libssl-dev \
      libxml2-dev \
      libicu-dev \
      libmcrypt-dev \
      zlib1g-dev \
      libpng12-dev \
      libjpeg62-turbo-dev \
      --no-install-recommends && rm -r /var/lib/apt/lists/* && updatedb

RUN git clone --depth 1 git://github.com/php-build/php-build.git \
      && bash /php-build/install.sh && rm -rf /php-build

ENV PHP_VERSION 5.2.17
RUN php-build $PHP_VERSION /usr

CMD ["php", "-a"]
