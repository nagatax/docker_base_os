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
export PACKAGE_VERSION=7.4.10
export PACKAGE_LATEST=7.4.10
export PACKAGE_SHA256="e720f1286f895ca37f1c75a2ca338ad2f2456664d7097298167181b25b212feb"
export D_IMAGE=${PACKAGE}:${PACKAGE_VERSION}
export COMPOSER_SHA="8a6138e2a05a8c28539c9f0fb361159823655d7ad2deecb371b04a83966c61223adc522b0189079e3e9e277cd72b8897"