# Install curl
#yum install -y curl

# Install inspec
curl "https://omnitruck.chef.io/install.sh" | bash -s -- -P inspec

# docker run
docker run -it -d --name sut docker.io/nagatax/gcc

echo "SOURCE_BRANCH:${SOURCE_BRANCH}"
echo "SOURCE_COMMIT:${SOURCE_COMMIT}"
echo "COMMIT_MSG:${COMMIT_MSG}"
echo "DOCKER_REPO:${DOCKER_REPO}"
echo "DOCKERFILE_PATH:${DOCKERFILE_PATH}"
echo "CACHE_TAG:${CACHE_TAG}"
echo "IMAGE_NAME:${IMAGE_NAME}"

# execute inspec
inspec exec . --controls=docker
inspec exec . -t docker://sut --controls=gcc

# docker container
docker rmi sut
