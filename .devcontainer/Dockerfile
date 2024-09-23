FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid

RUN apt-get update -y
RUN apt-get install -y \
    git \
    python3-pip \
    zsh \
    wget \
    python3-tk \
    curl \
    lsb-release \
    software-properties-common

# Install docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

RUN apt-get update -y
RUN apt-get install -y docker-ce docker-compose-plugin

# Create the user
ARG USERNAME=lab
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN usermod -aG docker $USERNAME
RUN gpasswd -a $USERNAME docker

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME

RUN curl -fsSL https://get.pulumi.com | sh

RUN pip3 install pdm
# Uses "robbyrussell" theme (original Oh My Zsh theme), with no plugins
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -t robbyrussell

RUN echo "export PATH=$PATH:/home/$USERNAME/.pulumi/bin:/home/$USERNAME/.local/bin" >> ~/.zshrc
