#!/bin/bash

export SPARK_HOME=/opt/spark
export MASTER_HOST=localhost

echo "Starting Spark Worker..."

$SPARK_HOME/sbin/start-worker.sh spark://p14:7077
