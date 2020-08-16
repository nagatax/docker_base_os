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
export PACKAGE_VERSION=7.4.9
export PACKAGE_LATEST=7.4.9
export PACKAGE_SHA256="c0c657b5769bc463f5f028b1f4fef8814d98ecf3459a402a9e30d41d68b2323e"
export D_IMAGE=${PACKAGE}:${PACKAGE_VERSION}
export COMPOSER_SHA="572cb359b56ad9ae52f9c23d29d4b19a040af10d6635642e646a7caa7b96de717ce683bd797a92ce99e5929cc51e7d5f"