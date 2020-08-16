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
export PACKAGE_VERSION=2.4.46
export PACKAGE_LATEST=2.4.46
export PACKAGE_SHA256="44b759ce932dc090c0e75c0210b4485ebf6983466fb8ca1b446c8168e1a1aec2"
export D_IMAGE=${PACKAGE}:${PACKAGE_VERSION}
