FROM debian:wheezy
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
      libbz2-dev \
      libcurl4-openssl-dev \
      libedit-dev \
      libsqlite3-dev \
      libssl-dev \
      libxml2-dev \
      libicu-dev \
      libmcrypt-dev \
      zlib1g-dev \
      libpng12-dev \
      libjpeg62-dev \
      libmysqlclient-dev \
      libreadline-dev \
      libtidy-dev \
      libxslt1-dev \
      libncurses5-dev \
      libpspell-dev \
      libmhash-dev \
      unixodbc-dev \
      --no-install-recommends && rm -r /var/lib/apt/lists/* \

      && git clone --depth 1 git://github.com/php-build/php-build.git \
      && bash /php-build/install.sh && rm -rf /php-build


RUN echo '--with-libdir=lib/x86_64-linux-gnu\n\
--enable-dba=shared\n\
--enable-dbase=shared\n\
--enable-mbregex\n\
--enable-json\n\
--enable-soap\n\
--enable-xmlreader=shared\n\
--enable-xmlwriter=shared\n\
--enable-gd-native-ttf\n\
--enable-force-cgi-redirect\n\
--with-bz2\n\
--with-gd\n\
--with-mhash\n\
--with-ncurses=shared\n\
--with-pcre-regex\n\
--with-pdo-odbc=unixODBC,/usr\n\
--with-pspell\n\
--with-layout=GNU\n\
--with-unixODBC=/usr\n\
--without-sqlite\n\
--without-mime-magic\n'\
>> /usr/local/share/php-build/default_configure_options \
      && sed -i 's/without-pear/with-pear/' /usr/local/share/php-build/default_configure_options


ENV PHP_VERSION 5.2.17
RUN php-build $PHP_VERSION /usr \
      && rm -rf /tmp/php-build*

CMD ["php", "-a"]
