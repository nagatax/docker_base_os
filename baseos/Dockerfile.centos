FROM centos:7

# IMAGE INFORMATION
LABEL maintainer="nagatax<4foview@gmail.com>" \
    title="baseos" \
    version="centos" \
    description="This image is base image"
 
# 共通の設定
ENV SRC_DIR="/usr/local/src" \
    INSTALL_DIR="/usr/local" \
    BUILD_DIR="/usr/local/build"

# 実行ユーザの変更
USER root

# GPG keyの設定
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

# 起動時のコマンドを設定
CMD ["/bin/bash"]
