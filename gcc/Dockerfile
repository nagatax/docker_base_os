FROM centos:7

# 実行ユーザの変更
USER root

# 実行ファイルのデプロイ
COPY deploy_files/gcc /usr/local/gcc
COPY deploy_files/.bashrc /root/.bashrc

# 必要なパッケージのインストール
RUN yum install -y \
  glibc-devel \
  glibc-headers \
  kernel-headers

# 起動時のコマンドを設定
CMD ["/bin/bash"]
