FROM ubuntu:18.04

ENV USR=docker \
    GRP=doers \
    UDPPRT=11560

EXPOSE ${UDPPRT}/udp

RUN apt-get -qq update && \
      apt-get -y -qq install \
        nano \
        netcat \
        openjdk-8-jdk \
        sudo \
        wget

RUN groupadd -r $GRP && \
    useradd --no-log-init -r -m -g $GRP $USR && \
    echo "${USR}:toothless" | chpasswd && \
    usermod -aG sudo $USR

USER $USR

WORKDIR /home/$USR

RUN mkdir -p bin/jars && \
    wget -q https://github.com/agaoglu/udp-kafka-bridge/releases/download/v0.1/udp-kafka-bridge-assembly-0.1.jar \
      --output-document ./bin/jars/udp-kafka-bridge-assembly-0.1.jar
