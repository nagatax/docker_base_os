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
export PACKAGE=gcc
export PACKAGE_VERSION=10.1.0
export PACKAGE_LATEST=10.1.0
export PACKAGE_SHA256=""
export D_IMAGE=${PACKAGE}:${PACKAGE_VERSION}
