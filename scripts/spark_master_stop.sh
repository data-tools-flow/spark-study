#!/usr/bin/env bash

export SPARK_HOME=/opt/spark

echo "stopping spark master.."

$SPARK_HOME/sbin/stop-master.sh
