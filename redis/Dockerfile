FROM centos:7

# 実行ユーザの変更
USER root

# 実行ファイルのデプロイ
COPY deploy_files/redis /usr/local/redis
COPY deploy_files/.bashrc /root/.bashrc

RUN set -x; \
    . ~/.bashrc \
  \
  && : "redisユーザの作成" \
  && groupadd -r redis && useradd -g redis -s /sbin/nologin -r redis \
  \
  && : "必要なパッケージのインストール" \
  && yum install -y \
    tcl \
    tcl-devel \
    which \
  \
  && : "データフォルダの作成と設定ファイルのコピー" \
  && mkdir /data \
  && cp -a /usr/local/redis/redis.conf /data \
  && chown redis:redis /data

# ボリュームと作業ディレクトリの設定
VOLUME /data
WORKDIR /data

# 待ち受けるポートの設定
EXPOSE 6379

# サーバの起動
CMD ["/usr/local/redis/bin/redis-server", "/data/redis.conf"]
