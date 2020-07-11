FROM nagatax/httpd:latest AS common

##################################################
# Create a build image
##################################################
FROM common AS  build

##################################################
# Install the oniguruma
##################################################

RUN set -x; \
      . ~/.bashrc \
    \
    && : "必要なフォルダの作成" \
    && dnf install -y \
        epel-release \
        http://rpms.famillecollet.com/enterprise/remi-release-8.rpm \
    && dnf --enablerepo=remi install -y oniguruma-devel \
    && dnf clean all

##################################################
# Install the PHP
##################################################

# Install PHP
ARG PHP
ARG PHP_VERSION
ENV PHP_PAKAGE="${PHP}-${PHP_VERSION}"
ENV PHP_PAKAGE_FILE="${PHP}-${PHP_VERSION}.tar.gz"
ENV PHP_URL="https://www.php.net/distributions/${PHP_PAKAGE_FILE}"
ARG PHP_SHA256

RUN set -x; \
      . ~/.bashrc \
    \
    && : "関連パッケージのインストール" \
    && dnf install -y --enablerepo=PowerTools \
        autoconf \
        automake \
        bison \
        curl-devel \
        file \
        libicu-devel \
        libjpeg-devel \
        libpng-devel \
        libxml2-devel \
        libzip-devel \
        make \
        openssl-devel \
        re2c \
        sqlite-devel \
        zip \
        unzip \
        wget \
    \
    && : "必要なフォルダの作成" \
    && mkdir -p "${BUILD_DIR}/${PHP_PAKAGE}" \
    && mkdir -p "${INSTALL_DIR}/${PHP}" \
    \
    && : "phpのインストール" \
    && cd "${SRC_DIR}" \
    && wget "${PHP_URL}" \
    && echo "${PHP_SHA256} *${PHP_PAKAGE_FILE}" | sha256sum -c - \
    && tar xvf "${PHP_PAKAGE_FILE}" \
    && cd "${BUILD_DIR}/${PHP_PAKAGE}" \
    && "${SRC_DIR}/${PHP_PAKAGE}/configure" \
        --enable-bcmath \
        --enable-calendar \
        --enable-fpm \
        --enable-mbstring \
        --enable-opcache \
        --enable-soap \
        --enable-zip \
        --prefix="${INSTALL_DIR}/${PHP}" \
        --with-apxs2="${INSTALL_DIR}/httpd/bin/apxs" \
        --with-pdo-mysql=mysqlnd \
        --with-pear \
        --with-curl \
        --with-openssl \
        --without-libzip \
        --with-zlib \
    && make -j`nproc` \
    && make install \
    && echo 'export PATH=${PATH}'":${INSTALL_DIR}/${PHP}/bin" >> /root/.bashrc \
    && cp -a "${SRC_DIR}/${PHP_PAKAGE}/php.ini-development" "${INSTALL_DIR}/${PHP}/lib/php.ini" \
    \
    && : "不要なファイルの削除" \
    && rm -rf "${SRC_DIR}/${PHP_PAKAGE}" \
        "${SRC_DIR}/${PHP_PAKAGE_FILE}" \
        "${BUILD_DIR}/${PHP_PAKAGE}" \
    && dnf clean all

# Update PEAR and PECL
RUN set -x; \
      . ~/.bashrc \
    \
    && pear config-set php_ini "${INSTALL_DIR}/${PHP}/lib/php.ini" \
    && pecl config-set php_ini "${INSTALL_DIR}/${PHP}/lib/php.ini"

# Install pecl pakages
RUN set -x; \
      . ~/.bashrc \
    \
    && dnf install -y --enablerepo=PowerTools \
        ImageMagick-devel \
        libmemcached-devel \
        libyaml-devel \
    \
    && sed -ie 's/;openssl.cafile=/openssl.cafile=\/etc\/ssl\/certs\/ca-bundle.crt/g' /usr/local/php/lib/php.ini \
    && pecl channel-update pecl.php.net \
    && pecl install \
        imagick \
        memcached \
        phpredis \
        yaml \
        xdebug \
    && : "Setting of xdebug" \
    && : "Replace 'zend_extension_ts' with 'zend_extension'. Because xdebug is not thread safe" \
    && sed -i -e 's/^zend_extension_ts="xdebug.so"/zend_extension="xdebug.so"/' /usr/local/php/lib/php.ini

# Install composer
ARG COMPOSER_SHA
RUN set -x; \
      . ~/.bashrc \
    \
    && : "関連パッケージのインストール" \
    && dnf install -y \
        git \
    \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '${COMPOSER_SHA}') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

##################################################
# Create a release image
##################################################
FROM common AS release

# Copy executable files
COPY --from=build /usr/local /usr/local
COPY --from=build /root/.bashrc /root/.bashrc

# Install related files
RUN set -x; \
      . ~/.bashrc \
    \
    && : "関連パッケージのインストール" \
    && : "oniguruma" \
    && dnf install -y \
        epel-release \
        http://rpms.famillecollet.com/enterprise/remi-release-8.rpm \
    && dnf --enablerepo=remi install -y oniguruma-devel \
    && : "PHP" \
    && dnf install -y --enablerepo=PowerTools \
        autoconf \
        automake \
        bison \
        curl-devel \
        file \
        libicu-devel \
        libjpeg-devel \
        libpng-devel \
        libxml2-devel \
        libzip-devel \
        make \
        openssl-devel \
        re2c \
        sqlite-devel \
        zip \
        unzip \
    && : "Xdebug" \
    && dnf install -y --enablerepo=PowerTools \
        ImageMagick-devel \
        libmemcached-devel \
        libyaml-devel \
    \
    && : "不要なファイルの削除" \
    && dnf clean all
