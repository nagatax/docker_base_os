#!/bin/bash

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
export PACKAGE_VERSION=7.4.5
export PACKAGE_LATEST=7.4.5
export PACKAGE_SHA256="1ef619411b0bd68c0fbfd2a6c622ad6bc524d0bceb8476fb9807a23a0fe9a343"
export D_IMAGE=${PACKAGE}:${PACKAGE_VERSION}
