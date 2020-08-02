#!/bin/bash
set -eu

type "inspec" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    # Install inspec
    curl "https://omnitruck.chef.io/install.sh" | bash -s -- -P inspec
fi

# run docker container (create & start)
docker container run -it -d --name sut "${D_IMAGE}"

# execute inspec
inspec exec ./gcc/tests --controls=docker --chef-license=accept-silent
inspec exec ./gcc/tests -t docker://sut --controls=gcc

# stop docker container
docker container stop sut

# remove docker container
docker container rm sut
