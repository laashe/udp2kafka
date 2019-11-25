#!/bin/sh

CONFFILE=~/udp-kafka-bridge.conf

echo -n \
"bind.host = 0.0.0.0\n\
bind.port = $UDPPORT\n\
topic = $KAFKATOPIC\n\
\n\
kafka {\n\
  metadata.broker.list = \"$KAFKAHOST:$KAFKAPORT\"\n\
  producer.type = \"async\"\n\
  serializer.class = \"kafka.serializer.StringEncoder\"\n\
  compression.codec = \"1\"\n\
}" > $CONFFILE

java \
    -Dconfig.file=$CONFFILE \
    -jar ~/bin/jars/udp-kafka-bridge-assembly-0.1.jar \
    &> bridge.log
