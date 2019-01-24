# Install curl
#yum install -y curl

# Install inspec
curl "https://omnitruck.chef.io/install.sh" | bash -s -- -P inspec

# docker run
docker run -it -d --name sut docker.io/nagatax/gcc

# execute inspec
inspec exec . --controls=docker
inspec exec . -t docker://sut --controls=gcc

# docker container
docker rmi sut
