#!/bin/sh
set -eu

# run docker container (create & start)
docker container run -it -d --name sut "${D_IMAGE}"

# execute inspec
inspec exec ./apache/tests --controls=docker --chef-license=accept-silent
inspec exec ./apache/tests -t docker://sut --controls=apache

# stop docker container
docker container stop sut

# remove docker container
docker container rm sut
