FROM centos:7

# 共通の設定
ENV SRC_DIR="/usr/local/src"
ENV INSTALL_DIR="/usr/local"

# 実行ユーザの変更
USER root

# GPG keyの設定
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

##################################################
# gccのインストール
##################################################
ENV GCC="gcc"
ENV GCC_VERSION="8.2.0"
ENV GCC_PAKAGE="${GCC}-${GCC_VERSION}"
ENV GCC_PAKAGE_FILE="${GCC_PAKAGE}.tar.gz"
ENV GCC_URL="http://ftp.tsukuba.wide.ad.jp/software/${GCC}/releases/${GCC_PAKAGE}/${GCC_PAKAGE_FILE}"

RUN yum -y install wget bzip2 \
    && cd "${SRC_DIR}" \
    && wget "${GCC_URL}" \
    && tar xvf "${GCC_PAKAGE_FILE}" \
    && cd "${GCC_PAKAGE}" \
    && ./contrib/download_prerequisites \
    && ./configure --enable-languages=c,c++ --prefix="${INSTALL_DIR}" --disable-multilib \
    && make -j`nproc` \
    && make install \
    && rm -rf "${SRC_DIR}/${GCC_PAKAGE}"
