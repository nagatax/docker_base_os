#!/bin/sh

##################################################
# 環境変数を定義する
#
# Environment Variables
#  PACKAGE: package name
#  PACKAGE_VERSION: package version
#  PACKAGE_LATEST: latest version of package
#  D_IMAGE: image name of Docker
#  DH_IMAGE: image name of Docker Hub
#  DH_LATEST: latest image name of Docker Hub
##################################################

# Set shell option
set -eu

# Enable BuildKit
export DOCKER_BUILDKIT=1

# Installing version
export PACKAGE=php
export PACKAGE_VERSION=7.4.12
export PACKAGE_LATEST=7.4.12
export PACKAGE_SHA256="f056d74409a71f17218f76538c6a2d7b59ee99db9db7685fa0ab9cd0d4c0f286"
export D_IMAGE=${PACKAGE}:${PACKAGE_VERSION}
export COMPOSER_SHA="c31c1e292ad7be5f49291169c0ac8f683499edddcfd4e42232982d0fd193004208a58ff6f353fde0012d35fdd72bc394"