#!/bin/bash

KAFAKA_HOME=/home/$USER/.local/kafka
KAFAKA_PROPERTIES=$KAFAKA_HOME/config/server.properties

# 첫 번째 인자를 변수에 저장
TOPIC_NAME=$1
# 두 번째 인자를 변수에 저장
GROUP_NAME=$2

echo "The first argument is: $GROUP_NAME"
echo "Creating Kafka Consumer Group: $GROUP_NAME"
echo "Kafka Home: $KAFAKA_HOME"
echo "Kafka Properties: $KAFAKA_PROPERTIES"

cd $KAFAKA_HOME

bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
  --topic $TOPIC_NAME --group $GROUP_NAME --from-beginning

echo "Kafka Consumer Group $GROUP_NAME created successfully"
