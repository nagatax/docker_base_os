#!/bin/sh
set -eu

# run docker container (create & start)
docker container run -it -d --name sut "${D_IMAGE}"

# execute inspec
bundle exec inspec exec . --controls=docker --chef-license=accept-silent
bundle exec inspec exec . -t docker://sut --controls=nginx

# stop docker container
docker container stop sut

# remove docker container
docker container rm sut
