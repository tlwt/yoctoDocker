# Base image for building Yocto images
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y

# Essentials
RUN apt-get install gawk wget locales cpio git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm make xsltproc docbook-utils fop dblatex xmlto git tar python sed cvs subversion coreutils texi2html python-pysqlite2 help2man mercurial groff curl lzop asciidoc u-boot-tools gawk wget gcc g++ desktop-file-utils libgl1-mesa-dev libglu1-mesa-dev openssl libssl-dev xutils-dev -y && apt-get install autoconf automake libtool libglib2.0-dev -yq --no-install-recommends  && rm -rf /var/lib/apt/lists/*

#Yocto Project Release
WORKDIR /root/bin
RUN curl https://storage.googleapis.com/git-repo-downloads/repo  > ./repo
RUN chmod a+x ./repo

RUN locale-gen "en_US.UTF-8" && update-locale LC_ALL="en_US.UTF-8"
ENV LC_ALL=en_US.UTF-8

RUN echo ' ' >> /root/.bashrc && \
    echo 'export PATH=~/bin:$PATH' >> /root/.bashrc && \
    echo 'export LC_ALL=en_US.UTF-8' >> /root/.bashrc && \
    echo 'export LANG=en_US.UTF-8' >> /root/.bashrc && \
    echo 'export LANGUAGE=en_US.UTF-8' >> /root/.bashrc

WORKDIR /repo
RUN git clone https://github.com/tlwt/yoctoDocker.git

WORKDIR /data

#release management
RUN apt-get update -y && apt-get install -y npm && rm -rf /var/lib/apt/lists/*
RUN npm install -g github-release-cli

ADD . /repo/yoctoDocker/

ENTRYPOINT /repo/yoctoDocker/scripts/startup.sh
