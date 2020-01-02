FROM nagatax/gcc:latest AS common

##################################################
# Create a build image
##################################################
FROM common AS  build

##################################################
# redisのインストール
##################################################
ENV REDIS="redis"
ENV REDIS_VERSION="5.0.5"
ENV REDIS_PAKAGE="${REDIS}-${REDIS_VERSION}"
ENV REDIS_PAKAGE_FILE="${REDIS_PAKAGE}.tar.gz"
ENV REDIS_URL="http://download.redis.io/releases/${REDIS_PAKAGE_FILE}"

RUN set -x; \
  . ~/.bashrc \
  \
  && : "関連パッケージのインストール" \
  && yum install -y \
  make \
  tcl \
  tcl-devel \
  wget \
  which \
  \
  && : "必要なフォルダの作成" \
  && mkdir -p "${INSTALL_DIR}/${REDIS}" \
  \
  && : "redisのインストール" \
  && cd "${SRC_DIR}" \
  && wget "${REDIS_URL}" \
  && tar xvf "${REDIS_PAKAGE_FILE}" \
  && cd "${REDIS_PAKAGE}" \
  && export CC=gcc \
  && make distclean \
  && make -j`nproc` |& tee make.log \
  #    && make check |& tee make_check.log \
  && make PREFIX="${INSTALL_DIR}/${REDIS}" install |& tee make_install.log \
  \
  && : "設定ファイルのコピーとパスの設定" \
  && cp -a redis.conf "${INSTALL_DIR}/${REDIS}" \
  && echo "export PATH=${INSTALL_DIR}/${REDIS}/bin"':${PATH}' >> ~/.bashrc \
  \
  && : "不要なファイルの削除" \
  && rm -rf "${SRC_DIR}/${REDIS_PAKAGE_FILE}"

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
  && : "redisユーザの作成" \
  && groupadd -r redis && useradd -g redis -s /sbin/nologin -r redis \
  \
  && : "関連パッケージのインストール" \
  && yum install -y \
  tcl \
  tcl-devel \
  which \
  \
  && : "データフォルダの作成と設定ファイルのコピー" \
  && mkdir /data \
  && cp -a /usr/local/redis/redis.conf /data \
  && chown redis:redis /data \
  \
  && : "不要なファイルの削除" \
  && yum clean all

# ボリュームと作業ディレクトリの設定
VOLUME /data
WORKDIR /data

# 待ち受けるポートの設定
EXPOSE 6379

# サーバの起動
CMD ["/usr/local/redis/bin/redis-server", "/data/redis.conf"]
