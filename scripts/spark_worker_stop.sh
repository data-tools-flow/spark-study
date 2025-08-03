#!/usr/bin/env bash

export SPARK_HOME=${SPARK_HOME:-/opt/spark}

echo "Stopping Spark worker..."

$SPARK_HOME/sbin/stop-worker.sh
