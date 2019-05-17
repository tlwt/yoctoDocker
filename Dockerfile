# Base image for building Yocto images
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y

# Essentials
RUN apt-get install gawk wget locales cpio git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm make xsltproc docbook-utils fop dblatex xmlto git tar python sed cvs subversion coreutils texi2html python-pysqlite2 help2man mercurial groff curl lzop asciidoc u-boot-tools gawk wget gcc g++ desktop-file-utils libgl1-mesa-dev libglu1-mesa-dev openssl libssl-dev xutils-dev -y && apt-get install autoconf automake libtool libglib2.0-dev -yq --no-install-recommends  && rm -rf /var/lib/apt/lists/*

RUN apt-get update -y && apt-get install -y npm && rm -rf /var/lib/apt/lists/*
RUN npm install -g github-release-cli


WORKDIR /home/appuser/bin
WORKDIR /repo
WORKDIR /data

# set local env
RUN locale-gen "en_US.UTF-8" && update-locale LC_ALL="en_US.UTF-8"
ENV LC_ALL=en_US.UTF-8

RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser
RUN chown -R appuser /home/appuser
RUN chown -R appuser /repo
RUN chown -R appuser /data

USER appuser

#Yocto Project Release

RUN curl https://storage.googleapis.com/git-repo-downloads/repo  > /home/appuser/bin/repo
RUN chmod a+x /home/appuser/bin/repo



RUN echo ' ' >> /home/appuser/.bashrc && \
    echo 'export PATH=~/bin:$PATH' >> /home/appuser/.bashrc && \
    echo 'export LC_ALL=en_US.UTF-8' >> /home/appuser/.bashrc && \
    echo 'export LANG=en_US.UTF-8' >> /home/appuser/.bashrc && \
    echo 'export LANGUAGE=en_US.UTF-8' >> /home/appuser/.bashrc

WORKDIR /repo
RUN git clone https://github.com/tlwt/yoctoDocker.git

WORKDIR /data



#release management



ENTRYPOINT /repo/yoctoDocker/scripts/startup.sh
