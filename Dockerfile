FROM ubuntu:18.04

ENV \
  GRP=doers \
  KAFKAHOST=localhost \
  KAFKAPORT=9092 \
  KAFKATOPIC=udp-sink \
  UDPPORT=11560 \
  USR=docker


EXPOSE ${UDPPORT}/udp

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
COPY --chown=${USR}:${GRP} ./start.sh start.sh

RUN chmod 744 ~/start.sh && \
    mkdir -p ~/bin/jars && \
    wget -q https://github.com/agaoglu/udp-kafka-bridge/releases/download/v0.1/udp-kafka-bridge-assembly-0.1.jar \
      --output-document ~/bin/jars/udp-kafka-bridge-assembly-0.1.jar

CMD ~/start.sh
