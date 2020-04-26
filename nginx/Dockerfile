FROM nagatax/gcc:latest AS common

##################################################
# Create a build image
##################################################
FROM common AS  build

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
    && dnf install -y \
        make \
        wget \
    && : "必要なフォルダの作成" \
    && mkdir -p "${INSTALL_DIR}/${PCRE}" \
    && : "pcreのインストール" \
    && cd "${SRC_DIR}" \
    && wget "${PCRE_URL}" \
    && wget "${PCRE_SIG_URL}" \
#    && gpg --verify "${PCRE_PAKAGE_FILE}.sig" \
    && tar xvf "${PCRE_PAKAGE_FILE}" \
    && cd "${PCRE_PAKAGE}" \
    && "./configure" \
        --prefix="${INSTALL_DIR}/${PCRE}" \
    && make -j`nproc` \
    && make install \
    && : "不要なファイルの削除"
#    && rm -rf "${SRC_DIR}/${PCRE_PAKAGE}" \
#        "${SRC_DIR}/${PCRE_PAKAGE_FILE}" \
#        "${BUILD_DIR}/${PCRE_PAKAGE}"

##################################################
# nginxのインストール
##################################################
ARG NGINX
ARG NGINX_VERSION
ENV NGINX_PAKAGE="${NGINX}-${NGINX_VERSION}"
ENV NGINX_PAKAGE_FILE="${NGINX_PAKAGE}.tar.gz"
ENV NGINX_URL="https://nginx.org/download/${NGINX_PAKAGE_FILE}"

RUN set -x; \
    . ~/.bashrc \
    \
    && : "関連パッケージのインストール" \
    && dnf install -y \
        make \
        wget \
    \
    && : "必要なフォルダの作成" \
#    && mkdir -p "${BUILD_DIR}/${NGINX_PAKAGE}" \
    && mkdir -p "${INSTALL_DIR}/${NGINX}" \
    \
    && : "nginxのインストール" \
    && cd "${SRC_DIR}" \
    && wget "${NGINX_URL}" \
    && tar xvf "${NGINX_PAKAGE_FILE}" \
    && cd "${NGINX_PAKAGE}" \
    && export CC=gcc \
    && "./configure" \
        --prefix="${INSTALL_DIR}/${NGINX}" \
        --with-pcre="${SRC_DIR}/${PCRE_PAKAGE}" \
    && make -j`nproc` |& tee make.log \
#    && make check |& tee make_check.log \
    && make install |& tee make_install.log \
    \
    && : "設定ファイルのコピーとパスの設定" \
    && echo "export PATH=${INSTALL_DIR}/${NGINX}/sbin"':${PATH}' >> ~/.bashrc \
    \
    && : "不要なファイルの削除" \
    && rm -rf "${SRC_DIR}/${NGINX_PAKAGE_FILE}"

# 起動時のコマンドを設定
CMD [ "/bin/bash" ]


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
  && : "nginxユーザの作成" \
  && groupadd -r nginx && useradd -g nginx -s /sbin/nologin -r nginx

# 待ち受けるポートの設定
EXPOSE 80

STOPSIGNAL SIGTERM

# サーバの起動
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
