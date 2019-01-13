FROM centos:7

# 実行ユーザの変更
USER root

COPY deploy_files/gcc-7.4.0 /usr/local/gcc-7.4.0
COPY deploy_files/.bashrc /root/.bashrc

RUN yum install -y \
  glibc-devel \
  glibc-headers \
  kernel-headers

CMD ["/bin/bash"]
