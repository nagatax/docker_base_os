FROM centos:7

# 共通の設定
ENV SRC_DIR="/usr/local/src"
ENV INSTALL_DIR="/usr/local"
ENV BUILD_DIR="/usr/local/build"

# 実行ユーザの変更
USER root

# GPG keyの設定
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

##################################################
# gccのインストール
# 
# options
#   --enable-languages: インストールするプログラミング言語を指定。デフォルトはC, C++, Objective-C, Fortran, Java。
#   --disable-multilib: 32bitライブラリを探さない。
#   --disable-bootstrap: bootstrapビルドを実施しない。bootstrapビルドはコンパイルを3回実施し、検証を行う。
# commands
#   download_prerequisites:コンパイルに必要なパッケージ(gmp/mpfr/mpc/isl)をダウンロードする。
##################################################
ENV GCC="gcc"
ENV GCC_VERSION="7.4.0"
ENV GCC_PAKAGE="${GCC}-${GCC_VERSION}"
ENV GCC_PAKAGE_FILE="${GCC_PAKAGE}.tar.gz"
ENV GCC_URL="http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/${GCC_PAKAGE}/${GCC_PAKAGE_FILE}"

RUN yum -y install wget bzip2 make gcc gcc-c++ file perl autoconf automake file libtool \
    && cd "${SRC_DIR}" \
    && wget "${GCC_URL}" \
    && tar xvf "${GCC_PAKAGE_FILE}" \
    && cd "${GCC_PAKAGE}" \
    && ./contrib/download_prerequisites \
    && mkdir "${BUILD_DIR}/${GCC_PAKAGE}" \
    && cd "${BUILD_DIR}/${GCC_PAKAGE}" \
    && "${SRC_DIR}/${GCC_PAKAGE}/configure" \
        --enable-languages=c,c++ \
        --prefix="${INSTALL_DIR}/${GCC_PAKAGE}" \
        --disable-multilib \
        --disable-bootstrap \
    && make -j`nproc` |& tee make.log \
    && make install \
    && ln -s "${INSTALL_DIR}/${GCC_PAKAGE}" "${INSTALL_DIR}/${GCC}" \
    && echo "export PATH=${INSTALL_DIR}/${GCC}/bin"':${PATH}' >> ~/.bashrc \
    && echo "${INSTALL_DIR}/${GCC}/lib" >> /etc/ld.so.conf.d/gcc.conf \
    && ldconfig \
    && rm -rf "${SRC_DIR}/${GCC_PAKAGE_FILE}"
