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
export PACKAGE_VERSION=8.0.0
export PACKAGE_LATEST=8.0.0
export PACKAGE_SHA256="3ed7b48d64357d3e8fa9e828dbe7416228f84105b8290c2f9779cd66be31ea71"
export D_IMAGE=${PACKAGE}:${PACKAGE_VERSION}
export COMPOSER_SHA="756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3"