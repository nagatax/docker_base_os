#!/bin/sh
set -eu

# run docker container (create & start)
docker container run -it -d --name sut "${D_IMAGE}"

# execute inspec
bundle exec inspec exec ./php/tests --controls=docker --chef-license=accept-silent
bundle exec inspec exec ./php/tests -t docker://sut --controls=php

# stop docker container
docker container stop sut

# remove docker container
docker container rm sut
