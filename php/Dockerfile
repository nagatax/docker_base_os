FROM nagatax/apache:latest AS common

##################################################
# Apacheのインストール
##################################################
FROM common AS  build

##################################################
# onigurumaのインストール
##################################################

RUN set -x; \
      . ~/.bashrc \
    \
    && : "必要なフォルダの作成" \
    && yum install -y \
        epel-release \
        http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
    && yum --enablerepo=remi install -y oniguruma-devel \
    && yum clean all

##################################################
# PHPのインストール
##################################################

# Install PHP
ENV PHP="php"
ENV PHP_VERSION="7.4.0"
ENV PHP_PAKAGE="${PHP}-${PHP_VERSION}"
ENV PHP_PAKAGE_FILE="${PHP}-${PHP_VERSION}.tar.gz"
ENV PHP_URL="https://www.php.net/distributions/${PHP_PAKAGE_FILE}"
ENV PHP_SHA256="004a1a8176176ee1b5c112e73d705977507803f425f9e48cb4a84f42b22abf22 *${PHP_PAKAGE_FILE}"

RUN set -x; \
      . ~/.bashrc \
    \
    && : "関連パッケージのインストール" \
    && yum install -y \
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
    \
    && : "必要なフォルダの作成" \
    && mkdir -p "${BUILD_DIR}/${PHP_PAKAGE}" \
    && mkdir -p "${INSTALL_DIR}/${PHP}" \
    \
    && : "phpのインストール" \
    && cd "${SRC_DIR}" \
    && wget "${PHP_URL}" \
    && echo "${PHP_SHA256}" | sha256sum -c - \
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
        --with-apxs2="${INSTALL_DIR}/${APACHE}/bin/apxs" \
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
    && yum clean all

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
    && yum install -y \
        ImageMagick-devel \
        libmemcached-devel \
        libyaml-devel \
    \
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
RUN set -x; \
      . ~/.bashrc \
    \
    && : "関連パッケージのインストール" \
    && yum install -y \
        git \
    \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
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
    && yum install -y \
        epel-release \
        http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
    && yum --enablerepo=remi install -y oniguruma-devel \
    && : "PHP" \
    && yum install -y \
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
    && yum install -y \
        ImageMagick-devel \
        libmemcached-devel \
        libyaml-devel \
    \
    && : "不要なファイルの削除" \
    && yum clean all
