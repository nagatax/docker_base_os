#!/bin/bash
set -eu

# Install inspec
curl "https://omnitruck.chef.io/install.sh" | bash -s -- -P inspec

# run docker container (create & start)
docker container run -it -d --name sut "${IMAGE_NAME}"

# execute inspec
inspec exec . --controls=docker
inspec exec . -t docker://sut --controls=redis

# stop docker container
docker container stop sut

# remove docker container
docker container rm sut
