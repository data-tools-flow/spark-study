#!/usr/bin/env bash

export SPARK_HOME=/opt/spark

echo "starting spark master.."

$SPARK_HOME/sbin/start-master.sh
