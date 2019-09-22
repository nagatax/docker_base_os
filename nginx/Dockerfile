FROM centos:7

# 実行ユーザの変更
USER root

# 実行ファイルのデプロイ
COPY deploy_files/nginx /usr/local/nginx
COPY deploy_files/.bashrc /root/.bashrc

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
