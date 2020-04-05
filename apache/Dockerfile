FROM nagatax/gcc:latest AS common

##################################################
# Create a build image
##################################################
FROM common AS  build

##################################################
# Install the Apache
##################################################
# Install apr
ENV APR="apr"
ENV APR_VERSION="1.6.5"
ENV APR_PAKAGE="${APR}-${APR_VERSION}"
ENV APR_PAKAGE_FILE="${APR_PAKAGE}.tar.gz"
ENV APR_URL="http://ftp.jaist.ac.jp/pub/apache/${APR}/${APR_PAKAGE_FILE}"
ENV APR_SHA256="70dcf9102066a2ff2ffc47e93c289c8e54c95d8dda23b503f9e61bb0cbd2d105 *${APR_PAKAGE_FILE}"

RUN set -x; \
      . ~/.bashrc \
       : "関連パッケージのインストール" \
    && yum install -y \
        file \
        make \
        wget \
    && : "必要なフォルダの作成" \
    && mkdir -p "${BUILD_DIR}/${APR_PAKAGE}" \
    && mkdir -p "${INSTALL_DIR}/${APR}" \
    && : "aprのインストール" \
    && cd "${SRC_DIR}" \
    && wget "${APR_URL}" \
    && echo "${APR_SHA256}" | sha256sum -c - \
    && tar xvf "${APR_PAKAGE_FILE}" \
    && cd "${APR_PAKAGE}" \
    && sed -ie 's/$RM "$cfgfile"/$RM -f "$cfgfile"/g' ./configure \
    && cd "${BUILD_DIR}/${APR_PAKAGE}" \
    && "${SRC_DIR}/${APR_PAKAGE}/configure" \
        --prefix="${INSTALL_DIR}/${APR}" \
    && make -j`nproc` \
    && make install \
    && : "不要なファイルの削除" \
    && rm -rf "${SRC_DIR}/${APR_PAKAGE}" \
        "${SRC_DIR}/${APR_PAKAGE_FILE}" \
        "${BUILD_DIR}/${APR_PAKAGE}"

# Install apr-util
ENV APR_UTIL="apr-util"
ENV APR_UTIL_VERSION="1.6.1"
ENV APR_UTIL_PAKAGE="${APR_UTIL}-${APR_UTIL_VERSION}"
ENV APR_UTIL_PAKAGE_FILE="${APR_UTIL_PAKAGE}.tar.gz"
ENV APR_UTIL_URL="http://ftp.jaist.ac.jp/pub/apache//${APR}/${APR_UTIL_PAKAGE_FILE}"
ENV APR_UTIL_SHA256="b65e40713da57d004123b6319828be7f1273fbc6490e145874ee1177e112c459 *${APR_UTIL_PAKAGE_FILE}"

RUN set -x; \
      . ~/.bashrc \
       : "関連パッケージのインストール" \
    && yum install -y \
        expat-devel \
        make \
        wget \
    && : "必要なフォルダの作成" \
    && mkdir -p "${BUILD_DIR}/${APR_UTIL_PAKAGE}" \
    && mkdir -p "${INSTALL_DIR}/${APR_UTIL}" \
    && : "apr-utilのインストール" \
    && cd "${SRC_DIR}" \
    && wget "${APR_UTIL_URL}" \
    && echo "${APR_UTIL_SHA256}" | sha256sum -c - \
    && tar xvf "${APR_UTIL_PAKAGE_FILE}" \
    && cd "${BUILD_DIR}/${APR_UTIL_PAKAGE}" \
    && "${SRC_DIR}/${APR_UTIL_PAKAGE}/configure" \
        --prefix="${INSTALL_DIR}/${APR_UTIL}" \
        --with-apr="${INSTALL_DIR}/${APR}" \
    && make -j`nproc` \
    && make install \
    && : "不要なファイルの削除" \
    && rm -rf "${SRC_DIR}/${APR_UTIL_PAKAGE}" \
        "${SRC_DIR}/${APR_UTIL_PAKAGE_FILE}" \
        "${BUILD_DIR}/${APR_UTIL_PAKAGE}"

# Install pcre
ENV PCRE="pcre"
ENV PCRE_VERSION="8.42"
ENV PCRE_PAKAGE="${PCRE}-${PCRE_VERSION}"
ENV PCRE_PAKAGE_FILE="${PCRE_PAKAGE}.tar.gz"
ENV PCRE_URL="https://ftp.pcre.org/pub/${PCRE}/${PCRE_PAKAGE_FILE}"
ENV PCRE_SIG_URL="https://ftp.pcre.org/pub/${PCRE}/${PCRE_PAKAGE_FILE}.sig"

RUN set -x; \
      . ~/.bashrc \
       : "関連パッケージのインストール" \
    && yum install -y \
        make \
        wget \
    && : "必要なフォルダの作成" \
    && mkdir -p "${BUILD_DIR}/${PCRE_PAKAGE}" \
    && mkdir -p "${INSTALL_DIR}/${PCRE}" \
    && : "pcreのインストール" \
    && cd "${SRC_DIR}" \
    && wget "${PCRE_URL}" \
    && wget "${PCRE_SIG_URL}" \
#    && gpg --verify "${PCRE_PAKAGE_FILE}.sig" \
    && tar xvf "${PCRE_PAKAGE_FILE}" \
    && cd "${BUILD_DIR}/${PCRE_PAKAGE}" \
    && "${SRC_DIR}/${PCRE_PAKAGE}/configure" \
        --prefix="${INSTALL_DIR}/${PCRE}" \
    && make -j`nproc` \
    && make install \
    && : "不要なファイルの削除" \
    && rm -rf "${SRC_DIR}/${PCRE_PAKAGE}" \
        "${SRC_DIR}/${PCRE_PAKAGE_FILE}" \
        "${BUILD_DIR}/${PCRE_PAKAGE}"

# Install openssl
ENV OPENSSL="openssl"
ENV OPENSSL_VERSION="1.1.1f"
ENV OPENSSL_PAKAGE="${OPENSSL}-${OPENSSL_VERSION}"
ENV OPENSSL_PAKAGE_FILE="${OPENSSL_PAKAGE}.tar.gz"
ENV OPENSSL_URL="https://www.openssl.org/source/${OPENSSL_PAKAGE_FILE}"
ENV OPENSSL_SHA256="186c6bfe6ecfba7a5b48c47f8a1673d0f3b0e5ba2e25602dd23b629975da3f35 *${OPENSSL_PAKAGE_FILE}"

RUN set -x; \
      . ~/.bashrc \
       : "関連パッケージのインストール" \
    && yum install -y \
        make \
        perl \
        zlib-devel \
        wget \
    && : "必要なフォルダの作成" \
    && mkdir -p "${BUILD_DIR}/${OPENSSL_PAKAGE}" \
    && mkdir -p "${INSTALL_DIR}/${OPENSSL}" \
    && : "opensslのインストール" \
    && cd "${SRC_DIR}" \
    && wget "${OPENSSL_URL}" \
    && echo "${OPENSSL_SHA256}" | sha256sum -c - \
    && tar xvf "${OPENSSL_PAKAGE_FILE}" \
    && cd "${BUILD_DIR}/${OPENSSL_PAKAGE}" \
    && "${SRC_DIR}/${OPENSSL_PAKAGE}/config" \
        --prefix="${INSTALL_DIR}/${OPENSSL}" \
        shared \
        zlib \
    && make -j`nproc` \
    && make install \
    && echo 'export PATH=${PATH}'":${INSTALL_DIR}/${OPENSSL}/bin" >> /root/.bashrc \
    && echo "${INSTALL_DIR}/${OPENSSL}/lib" > /etc/ld.so.conf.d/lib64.conf \
    && ldconfig \
    && : "不要なファイルの削除" \
    && rm -rf "${SRC_DIR}/${OPENSSL_PAKAGE}" \
        "${SRC_DIR}/${OPENSSL_PAKAGE_FILE}" \
        "${BUILD_DIR}/${OPENSSL_PAKAGE}"

# Install Apache
ARG APACHE
ARG APACHE_VERSION
ENV APACHE_PAKAGE="${APACHE}-${APACHE_VERSION}"
ENV APACHE_PAKAGE_FILE="${APACHE_PAKAGE}.tar.gz"
ENV APACHE_URL="http://ftp.jaist.ac.jp/pub/apache/${APACHE}/${APACHE_PAKAGE_FILE}"
ARG APACHE_SHA256

RUN set -x; \
      . ~/.bashrc \
       : "関連パッケージのインストール" \
    && yum install -y \
        make \
        wget \
    && : "必要なフォルダの作成" \
    && mkdir -p "${BUILD_DIR}/${APACHE_PAKAGE}" \
    && mkdir -p "${INSTALL_DIR}/${APACHE}" \
    && : "apacheのインストール" \
    && cd "${SRC_DIR}" \
    && wget "${APACHE_URL}" \
    && echo "${APACHE_SHA256} *${APACHE_PAKAGE_FILE}" | sha256sum -c - \
    && tar xvf "${APACHE_PAKAGE_FILE}" \
    && cd "${BUILD_DIR}/${APACHE_PAKAGE}" \
    && "${SRC_DIR}/${APACHE_PAKAGE}/configure" \
        --enable-mods-shared=all \
        --enable-module=status \
        --enable-mpms-shared=all \
        --enable-shared=ssl \
        --enable-ssl \
        --prefix="${INSTALL_DIR}/${APACHE}" \
        --with-apr="${INSTALL_DIR}/${APR}" \
        --with-apr-util="${INSTALL_DIR}/${APR_UTIL}" \
        --with-pcre="${INSTALL_DIR}/${PCRE}/bin/pcre-config" \
        --with-ssl="${INSTALL_DIR}/${OPENSSL}" \
    && make -j`nproc` \
    && make install \
    && echo 'export PATH=${PATH}'":${INSTALL_DIR}/${APACHE}/bin" >> /root/.bashrc \
    && useradd -s /sbin/nologin apache \
    && chown -R apache:apache "${INSTALL_DIR}/${APACHE}/" \
    && : "不要なファイルの削除" \
    && rm -rf "${SRC_DIR}/${APACHE_PAKAGE}" \
        "${SRC_DIR}/${APACHE_PAKAGE_FILE}" \
        "${BUILD_DIR}/${APACHE_PAKAGE}"

##################################################
# Create a release image
##################################################
FROM common AS release

# Copy executable files
COPY --from=build /usr/local /usr/local
COPY --from=build /root/.bashrc /root/.bashrc
COPY "$(dirname $0)/conf/httpd.conf" /usr/local/httpd/conf/

# Install openssl
ENV OPENSSL="openssl"

# Install related files
RUN set -x; \
      . ~/.bashrc \
    \
    && : "関連パッケージのインストール" \
    && : "apr-util" \
    && yum install -y \
        expat-devel \
    && : "openssl" \
    && yum install -y \
        perl \
        zlib-devel \
    \
    && : "設定の追加" \
    && : "openssl" \
    && echo "${INSTALL_DIR}/${OPENSSL}/lib" > /etc/ld.so.conf.d/lib64.conf \
    && ldconfig \
    \
    && : "不要なファイルの削除" \
    && yum clean all

# 待ち受けるポートの設定
EXPOSE 80

STOPSIGNAL SIGTERM

# サーバの起動
CMD ["/usr/local/httpd/bin/apachectl", "-D", "FOREGROUND"]
