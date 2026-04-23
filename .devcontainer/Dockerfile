# FROM mcr.microsoft.com/devcontainers/base:ubuntu24.04
FROM ubuntu:24.04
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends git curl wget openssl ca-certificates build-essential sudo

ARG SCRIPTS_DIR=/tmp/devcontainer-scripts
COPY scripts $SCRIPTS_DIR
RUN chmod +x $SCRIPTS_DIR/*.sh
RUN $SCRIPTS_DIR/proxy_certificate.sh

ARG CHEF_VERSION=latest
RUN curl -fsSL https://omnitruck.chef.io/install.sh | bash -s -- -v "$CHEF_VERSION"
ENV CHEF_LICENSE=accept
ENV PATH="/opt/chef/bin:$PATH"

RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ubuntu-nopasswd
USER ubuntu


