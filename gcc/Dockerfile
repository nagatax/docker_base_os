FROM nagatax/baseos:centos8

##################################################
# gccのインストール
#
# options
#   --disable-bootstrap: bootstrapビルドを実施しない。bootstrapビルドはコンパイルを3回実施し、検証を行う。
#   --disable-multilib: 32bitライブラリを探さない。
#   --enable-languages: インストールするプログラミング言語を指定。デフォルトはC, C++, Objective-C, Fortran, Java。
#   --prefix: インストール先のパス。
#   --with-system-zlib: OSにインストール済みのzlibを使用する。
# commands
#   download_prerequisites:コンパイルに必要なパッケージ(gmp/mpfr/mpc/isl)をダウンロードする。
# note
#   "make check"を実行するときはdockerを特権モード(--privileged)にする。
#   (asanの試験結果がFAILになる)
#   また、試験中にスタック領域が不足するため、ulimitコマンドでスタック領域を拡張する。
##################################################
ARG GCC
ARG GCC_VERSION
ENV GCC_PAKAGE="${GCC}-${GCC_VERSION}"
ENV GCC_PAKAGE_FILE="${GCC_PAKAGE}.tar.gz"
ENV GCC_URL="https://ftp.jaist.ac.jp/pub/GNU/${GCC}/${GCC_PAKAGE}/${GCC_PAKAGE_FILE}"
ENV GCC_SIG="https://ftp.jaist.ac.jp/pub/GNU/${GCC}/${GCC_PAKAGE}/${GCC_PAKAGE_FILE}.sig"

# IMAGE INFORMATION
LABEL title="${GCC}" \
    version="${GCC_VERSION}" \
    description="This is image which installed the gcc"

RUN set -x; \
       : "システムを最新の状態に更新" \
    && dnf update -y \
    && : "関連パッケージのインストール" \
    && dnf --enablerepo=PowerTools install -y \
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
    \
    && : "必要なフォルダの作成" \
    && mkdir -p "${BUILD_DIR}/${GCC_PAKAGE}" \
    && mkdir -p "${INSTALL_DIR}/${GCC}" \
    \
    && : "gccのインストール" \
    && cd "${SRC_DIR}" \
    && wget "${GCC_URL}" \
    && tar xvf "${GCC_PAKAGE_FILE}" \
    && cd "${GCC_PAKAGE}" \
    && ./contrib/download_prerequisites \
    && cd "${BUILD_DIR}/${GCC_PAKAGE}" \
    && "${SRC_DIR}/${GCC_PAKAGE}/configure" \
#        --disable-bootstrap \
        --disable-multilib \
        --enable-languages=c,c++ \
        --prefix="${INSTALL_DIR}/${GCC}" \
        --with-system-zlib \
    && make -j`nproc` |& tee make.log \
#    && ulimit -s 32768
#    && make check |& tee make_check.log \
    && make install-strip |& tee make_install.log \
#    && make install |& tee make_install.log \
    && libtool --finish "${INSTALL_DIR}/${GCC}/libexec/gcc/x86_64-pc-linux-gnu/${GCC_VERSION}" \
    \
    && : "パスの設定とデバッグファイルのリネーム" \
    && echo "export PATH=${INSTALL_DIR}/${GCC}/bin"':${PATH}' >> ~/.bashrc \
    && rm -f "${INSTALL_DIR}/${GCC}"/lib64/libstdc++.so.*-gdb.py \
    \
    && : "共有ライブラリの設定" \
    && if [ -z ${LD_LIBRARY_PATH} ] ; then \
        echo "LD_LIBRARY_PATH=${INSTALL_DIR}/${GCC}/lib64:${INSTALL_DIR}/${GCC}/libexec/gcc/x86_64-pc-linux-gnu/${GCC_VERSION}:${INSTALL_DIR}/${GCC}/lib/gcc/x86_64-pc-linux-gnu/${GCC_VERSION}/plugin" >> ~/.bashrc ; \
       else \
        echo "LD_LIBRARY_PATH=${INSTALL_DIR}/${GCC}/lib64:${INSTALL_DIR}/${GCC}/libexec/gcc/x86_64-pc-linux-gnu/${GCC_VERSION}:${INSTALL_DIR}/${GCC}/lib/gcc/x86_64-pc-linux-gnu/${GCC_VERSION}/plugin"':${LD_LIBRARY_PATH}' >> ~/.bashrc ; \
       fi \
    \
    && : "不要なファイルの削除" \
    && rm -rf "${SRC_DIR}/${GCC_PAKAGE}" \
        "${SRC_DIR}/${GCC_PAKAGE_FILE}" \
        "${BUILD_DIR}/${GCC_PAKAGE}" \
    && : "不要なパッケージの削除" \
    && dnf remove -y \
        gcc \
        gcc-c++ \
        perl \
        wget \
    && : "gccの実行時に必要なパッケージのインストール" \
    && dnf install -y \
        glibc-devel \
    && : "dnfのキャッシュをクリア" \
    && rm -rf /var/cache/dnf/* \
    && dnf clean all

# 起動時のコマンドを設定
CMD [ "/bin/bash" ]
