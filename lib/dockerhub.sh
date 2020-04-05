##########################################################
# DockerHubにイメージを登録する
#
# Arguments:
#   1:DockerHubのログインID
#   2:DockerHubのパスワード
#   3:Dockerイメージ名
#   4:パッケージ名
#   5:パッケージのバージョン
#   6:パッケージの最新バージョン
# Usage:
#   pushImage DockerHubのログインID DockerHubのパスワード Dockerイメージ名 \
#             パッケージ名 パッケージのバージョン パッケージの最新バージョン
##########################################################
pushImage() {

    local login_id=${1}
    local password=${2}
    local docker_image=${3}
    local package=${4}
    local version=${5}
    local latest=${6}

    # Register in Docker Hub
    ## Rename image name
    docker image tag ${docker_image} "${login_id}/${docker_image}"

    ## Login
    echo ${password} | base64 -d | docker login -u ${login_id} --password-stdin

    ## Push docker image
    echo "Pushing docker image"
    docker image push "${login_id}/${docker_image}"

    if [ "x${version}" = "x${latest}" ]; then
        ## Push docker latest image
        echo "Pushing docker latest image"
        local latest_version="${login_id}/${package}":latest
        docker image tag ${docker_image} ${latest_version}
        docker image push ${latest_version}
    fi

    ## Logout
    docker logout

}
