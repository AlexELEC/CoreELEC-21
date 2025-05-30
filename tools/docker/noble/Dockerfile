FROM ubuntu:noble

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y locales sudo

RUN locale-gen en_US.UTF-8 \
 && update-locale LANG=en_US.UTF-8 LANGUAGE=en_US:en
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

RUN useradd docker -U -G sudo -m -s /bin/bash \
 && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt-get update

RUN apt-get install -y \
    wget bash bc gcc-13 cpp-13 sed patch patchutils tar bzip2 gzip xz-utils zstd perl gawk gperf zip \
      unzip diffutils lzop make file g++-13 xfonts-utils xsltproc default-jre-headless python3 \
      libc6-dev libncurses5-dev libjson-perl libxml-parser-perl libparse-yapp-perl rdfind \
      golang-1.23-go git openssh-client rsync \
    --no-install-recommends \
    && ln -s /usr/lib/go-1.23 /usr/lib/go \
    && ln -s /usr/lib/go-1.23/bin/go /usr/bin/go \
    && ln -s /usr/lib/go-1.23/bin/gofmt /usr/bin/gofmt

RUN if [ "$(uname -m)" = "aarch64" ]; then \
  echo 'deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ noble main restricted universe multiverse' > /etc/apt/sources.list.d/amd64.list; \
  echo 'deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ noble-updates main restricted universe multiverse' >> /etc/apt/sources.list.d/amd64.list; \
  echo 'deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ noble-security main restricted universe multiverse' >> /etc/apt/sources.list.d/amd64.list; \
  echo 'deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ noble-backports main restricted universe multiverse' >> /etc/apt/sources.list.d/amd64.list; \
  apt-get update; \
  dpkg --add-architecture amd64; \
  apt-get install -y libc6:amd64 qemu-user-binfmt --no-install-recommends; \
 fi

RUN rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 100 \
    --slave /usr/bin/cpp cpp /usr/bin/cpp-13 \
    --slave /usr/bin/g++ g++ /usr/bin/g++-13 \
    --slave /usr/bin/gcov gcov /usr/bin/gcov-13
RUN update-alternatives --config gcc

USER docker
