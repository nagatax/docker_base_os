##################################################
# Setup develop image
##################################################

FROM centos:7 AS devlop_image

# 共通の設定
ENV SRC_DIR="/usr/local/src"
ENV INSTALL_DIR="/usr/local"
ENV BUILD_DIR="/usr/local/build"

# 実行ユーザの変更
USER root

# GPG keyの設定
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#
# gccのインストール
#
# options
#   --disable-bootstrap: bootstrapビルドを実施しない。bootstrapビルドはコンパイルを3回実施し、検証を行う。
#   --disable-multilib: 32bitライブラリを探さない。
#   --enable-languages: インストールするプログラミング言語を指定。デフォルトはC, C++, Objective-C, Fortran, Java。
#   --with-system-zlib: OSにインストール済みのzlibを使用する。
# commands
#   download_prerequisites:コンパイルに必要なパッケージ(gmp/mpfr/mpc/isl)をダウンロードする。
# note
#   "make check"を実行するときはdockerを特権モード(--privileged)にする。
#   (asanの試験結果がFAILになる)
#   また、試験中にスタック領域が不足するため、ulimitコマンドでスタック領域を拡張する。
#
ENV GCC="gcc"
ENV GCC_VERSION="7.4.0"
ENV GCC_PAKAGE="${GCC}-${GCC_VERSION}"
ENV GCC_PAKAGE_FILE="${GCC_PAKAGE}.tar.gz"
ENV GCC_URL="http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/${GCC_PAKAGE}/${GCC_PAKAGE_FILE}"

RUN set -x; \
       : "関連パッケージのインストール" \
    && yum install -y \
        autoconf \
        autogen \
        automake \
        bzip2 \
        dejagnu \
        file \
        flex \
        gcc \
        gcc-c++ \
        gettext \
        gperf \
        libtool \
        make \
        patch \
        perl \
        texinfo \
        wget \
        zlib-devel \
    && rm -rf /var/cache/yum/* \
    && yum clean all \
    && : "必要なフォルダの作成" \
    && mkdir -p "${BUILD_DIR}/${GCC_PAKAGE}" \
    && mkdir -p "${INSTALL_DIR}/${GCC_PAKAGE}" \
    && : "gccのインストール" \
    && cd "${SRC_DIR}" \
    && wget "${GCC_URL}" \
    && tar xvf "${GCC_PAKAGE_FILE}" \
    && cd "${GCC_PAKAGE}" \
    && ./contrib/download_prerequisites \
    && cd "${BUILD_DIR}/${GCC_PAKAGE}" \
    && "${SRC_DIR}/${GCC_PAKAGE}/configure" \
        --disable-bootstrap \
        --disable-multilib \
#        --enable-bootstrap \
        --enable-languages=c,c++ \
        --prefix="${INSTALL_DIR}/${GCC_PAKAGE}" \
        --with-system-zlib \
    && make -j`nproc` |& tee make.log \
#    && ulimit -s 32768
#    && if [ "x${IS_DEVELOPMENT}" = "xtrue" ] ; then make check |& tee make_check.log; fi \
    && make install-strip |& tee make_install.log \
#    && make install |& tee make_install.log \
    && ln -s "${INSTALL_DIR}/${GCC_PAKAGE}" "${INSTALL_DIR}/${GCC}" \
    && libtool --finish "${INSTALL_DIR}/${GCC}/libexec/gcc/x86_64-pc-linux-gnu/${GCC_VERSION}" \
    && echo "export PATH=${INSTALL_DIR}/${GCC}/bin"':${PATH}' >> ~/.bashrc \
    && mv "${INSTALL_DIR}/${GCC}/lib64/libstdc++.so.6.0.24-gdb.py" "${INSTALL_DIR}/${GCC}/lib64/ignore-libstdc++.so.6.0.24-gdb.py" \
    && : "共有ライブラリの設定" \
    && if [ -z ${LD_LIBRARY_PATH} ] ; then \
        echo "LD_LIBRARY_PATH=${INSTALL_DIR}/${GCC}/lib64:${INSTALL_DIR}/${GCC}/libexec/gcc/x86_64-pc-linux-gnu/${GCC_VERSION}:${INSTALL_DIR}/${GCC}/lib/gcc/x86_64-pc-linux-gnu/${GCC_VERSION}/plugin" >> ~/.bashrc ; \
       else \
        echo "LD_LIBRARY_PATH=${INSTALL_DIR}/${GCC}/lib64:${INSTALL_DIR}/${GCC}/libexec/gcc/x86_64-pc-linux-gnu/${GCC_VERSION}:${INSTALL_DIR}/${GCC}/lib/gcc/x86_64-pc-linux-gnu/${GCC_VERSION}/plugin"':${LD_LIBRARY_PATH}' >> ~/.bashrc ; \
       fi \
    && : "不要なファイルの削除" \
    && rm -rf "${SRC_DIR}/${GCC_PAKAGE_FILE}"

CMD ["/bin/bash"]

##################################################
# Setup release image
##################################################
FROM centos:7

COPY --from=devlop_image "${INSTALL_DIR}/${GCC}" "${INSTALL_DIR}/${GCC}"
COPY --from=devlop_image "~/.bashrc" "~/.bashrc"

CMD ["/bin/bash"]
