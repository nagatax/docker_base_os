FROM centos:8

# IMAGE INFORMATION
LABEL maintainer="nagatax<4foview@gmail.com>" \
    title="baseos" \
    version="centos" \
    description="This image is base image"
 
# COMMON SETTING
ENV SRC_DIR="/usr/local/src" \
    INSTALL_DIR="/usr/local" \
    BUILD_DIR="/usr/local/build"

# Change executable user
USER root

RUN set -x; \
    : "Set a GPG key" \
    && rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial \
    && yum update -y \
    && yum clean all

# Set a command when system will start
CMD ["/bin/bash"]
