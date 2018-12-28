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

# Install gmp
#ENV GMP="gmp"
#ENV GMP_VERSION="6.1.0"
#ENV GMP_PAKAGE="${GMP}-${GMP_VERSION}"
#ENV GMP_PAKAGE_FILE="${GMP_PAKAGE}.tar.bz2"
#ENV GMP_URL="ftp://gcc.gnu.org/pub/gcc/infrastructure/${GMP_PAKAGE_FILE}"
#
#RUN yum -y install wget bzip2 gcc gcc-c++ autoconf automake make file libtool \
#    && cd "${SRC_DIR}" \
#    && wget "${GMP_URL}" \
#    && tar xvf "${GMP_PAKAGE_FILE}" \
#    && cd "${GMP_PAKAGE}" \
#    && ./configure --prefix="${INSTALL_DIR}/${GMP_PAKAGE}" --enable-cxx \
#    && make -j`nproc` \
#    && make install \
#    && ln -s "${INSTALL_DIR}/${GMP_PAKAGE}" "${INSTALL_DIR}/${GMP}" \
#    && rm -rf "${SRC_DIR}/${GMP_PAKAGE}"
#
# Install isl
#ENV ISL="isl"
#ENV ISL_VERSION="0.18"
#ENV ISL_PAKAGE="${ISL}-${ISL_VERSION}"
#ENV ISL_PAKAGE_FILE="${ISL_PAKAGE}.tar.bz2"
#ENV ISL_URL="ftp://gcc.gnu.org/pub/gcc/infrastructure/${ISL_PAKAGE_FILE}"
#
#RUN yum -y install wget bzip2 gcc file \
#    && mkdir "${INSTALL_DIR}/${ISL_PAKAGE}" \
#    && cd "${SRC_DIR}" \
#    && wget "${ISL_URL}" \
#    && tar xvf "${ISL_PAKAGE_FILE}" \
#    && cd "${ISL_PAKAGE}" \
#    && ./configure --prefix="${INSTALL_DIR}/${ISL_PAKAGE}" --with-gmp-prefix="${INSTALL_DIR}/${GMP}" \
#    && make -j`nproc` \
#    && make install \
#    && ln -s "${INSTALL_DIR}/${ISL_PAKAGE}" "${INSTALL_DIR}/${ISL}" \
#    && rm -rf "${SRC_DIR}/${ISL_PAKAGE}"
#
# Install gcc
# options
#   --enable-languages: インストールするプログラミング言語を指定。デフォルトはC, C++, Objective-C, Fortran, Java。
#   --disable-multilib: 32bitライブラリを探さない。
#   --disable-bootstrap: bootstrapビルドを実施しない。bootstrapビルドはコンパイルを3回実施し、検証を行う。
# commands
#   download_prerequisites:コンパイルに必要なパッケージ(gmp/mpfr/mpc/isl)をダウンロードする。
#

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
    && mkdir "${SRC_DIR}/${GCC_PAKAGE}_build" \
    && cd "${SRC_DIR}/${GCC_PAKAGE}_build" \
    && "${SRC_DIR}/${GCC_PAKAGE}/configure" \
        --enable-languages=c,c++ \
        --prefix="${INSTALL_DIR}/${GCC_PAKAGE}" \
        --disable-multilib \
        --disable-bootstrap \
    && make -j`nproc` |& tee make.log \
    && make install \
    && ln -s "${INSTALL_DIR}/${GCC_PAKAGE}" "${INSTALL_DIR}/${GCC}" \
    && echo 'export PATH=${PATH}'":${INSTALL_DIR}/${GCC}/bin" >> ~/.bashrc \
    && echo 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}'":${INSTALL_DIR}/${GCC}/lib" >> ~/.bashrc \
    && rm -rf "${SRC_DIR}/${GCC_PAKAGE}"
