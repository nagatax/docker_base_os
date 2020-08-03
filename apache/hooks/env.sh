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
export PACKAGE=httpd
export PACKAGE_VERSION=2.4.43
export PACKAGE_LATEST=2.4.43
export PACKAGE_SHA256="2624e92d89b20483caeffe514a7c7ba93ab13b650295ae330f01c35d5b50d87f"
export D_IMAGE=${PACKAGE}:${PACKAGE_VERSION}
