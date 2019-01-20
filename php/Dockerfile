FROM centos:7

# 実行ユーザの変更
USER root

COPY deploy_files/apr      /usr/local/apr
COPY deploy_files/apr-util /usr/local/apr-util
COPY deploy_files/pcre     /usr/local/pcre
COPY deploy_files/openssl  /usr/local/openssl
COPY deploy_files/httpd    /usr/local/httpd
COPY deploy_files/php      /usr/local/phpS
COPY deploy_files/.bashrc  /root/.bashrc

#RUN yum install -y \
#  glibc-devel \
#  glibc-headers \
#  kernel-headers

CMD ["/bin/bash"]
