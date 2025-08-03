#!/usr/bin/env bash

echo "installing Spark..."

export SPARK_VERSION=4.0.0

# 1. download Spark

wget https://dlcdn.apache.org/spark/spark-4.0.0/spark-4.0.0-bin-hadoop3.tgz

# 2. extract the tar file

#tar -zxvf spark-4.0.0-bin-hadoop3.tgz

sleep 1

# 3. move to /opt

mv spark-4.0.0-bin-hadoop3 /opt/spark
