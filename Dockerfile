FROM ubuntu:jammy as base

ARG USERNAME=user
ARG UID=1000
ARG GID=1000
ARG DEBIAN_FRONTEND=noninteractive

ENV TERM=xterm-256color

# System setup
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    sudo \
    software-properties-common
# Install Ansible
RUN add-apt-repository -y --update ppa:ansible/ansible && \
    apt-get install -y ansible
# Cleanup
RUN apt-get clean autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove

# Create a sudo user
RUN groupadd -g ${GID} -o ${USERNAME} && \
    useradd -m -u ${UID} -g ${GID} -o -s /bin/bash ${USERNAME} && \
    usermod -a -G root ${USERNAME} && \
    echo ${USERNAME}:${USERNAME} | chpasswd && \
    adduser ${USERNAME} sudo && \
    passwd -d ${USERNAME}
USER ${USERNAME}
WORKDIR /home/${USERNAME}

# Build from base
FROM base as custom
COPY --chown=$USERNAME:$USERNAME ansible ./ansible

# run ansible-playbook
ENTRYPOINT ["/bin/bash", "./ansible/entrypoint"]
