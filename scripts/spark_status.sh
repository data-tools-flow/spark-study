#!/usr/bin/env bash

SPARK_HOME=${SPARK_HOME:-/opt/spark}
MASTER_WEB_UI_PORT=8080
MASTER_URL="http://localhost:$MASTER_WEB_UI_PORT"

echo "=== Spark Status Check ==="
echo "SPARK_HOME: $SPARK_HOME"
echo

# check spark processes
echo "[1] check JVM Process (Master / Worker)"
jps | grep -E 'Master|Worker' || echo "No Spark Master or Worker processes found"
echo

MASTER_LOG=$(ls -t $SPARK_HOME/logs/*Master*.out 2>/dev/null | head -n 1)
if [ -n "$MASTER_LOG" ]; then
  echo "[2] Master log"
  tail -n 5 "$MASTER_LOG"
else
  echo "[2] No Master log found"
fi
echo

echo "[3] check WEB UI status ($MASTER_URL)"
if curl --silent --head "$MASTER_URL" | grep "200 OK" >/dev/null; then
  echo "Spark Master Web UI is accessible at $MASTER_URL"
else
  echo "Spark Master Web UI is not accessible at $MASTER_URL"
fi
