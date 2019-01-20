FROM centos:7

# 実行ユーザの変更
USER root

# redisユーザの作成
RUN groupadd -r redis && useradd -r -g redis redis

# 実行ファイルのデプロイ
COPY deploy_files/redis /usr/local/redis
COPY deploy_files/.bashrc /root/.bashrc

# 必要なパッケージのインストール
RUN yum install -y \
  tcl \
  tcl-devel \
  which

# データフォルダの作成
RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

# 待ち受けるポートの設定
EXPOSE 6379

# サーバの起動
CMD ["/usr/local/redis/bin/redis-server"]
