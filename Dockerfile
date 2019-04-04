# Base image for building Yocto images
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update -y && apt-get upgrade -y

#Essentials
RUN apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm -y

#Documentation
RUN apt-get install make xsltproc docbook-utils fop dblatex xmlto -y

#ADT Installer Extra
RUN apt-get install autoconf automake libtool libglib2.0-dev -yq --no-install-recommends


#GIT, Python etc.
RUN apt-get install git tar python sed cvs subversion coreutils texi2html python-pysqlite2 help2man mercurial groff curl lzop asciidoc u-boot-tools gawk wget gcc g++ desktop-file-utils libgl1-mesa-dev libglu1-mesa-dev openssl libssl-dev xutils-dev -y

#Yocto Project Release
WORKDIR /root
RUN mkdir ~/bin
RUN curl https://storage.googleapis.com/git-repo-downloads/repo  > ~/bin/repo
RUN chmod a+x ~/bin/repo

RUN apt-get update -y
RUN apt-get install -y locales
RUN locale-gen "en_US.UTF-8"
RUN update-locale LC_ALL="en_US.UTF-8"

RUN export LC_ALL=en_US.UTF-8

#missing packages - reorder later
RUN apt-get install cpio -y

RUN echo ' ' >> /root/.bashrc
RUN echo 'export PATH=~/bin:$PATH' >> /root/.bashrc
RUN echo 'export LC_ALL=en_US.UTF-8' >> /root/.bashrc
RUN echo 'export LANG=en_US.UTF-8' >> /root/.bashrc
RUN echo 'export LANGUAGE=en_US.UTF-8' >> /root/.bashrc
