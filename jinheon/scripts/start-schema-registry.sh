#!/bin/bash

CONFLUENT_HOME=~/.local/confluent

#schema-registry-start $CONFLUENT_HOME/etc/schema-registry/schema-registry.properties

$CONFLUENT_HOME/bin/schema-registry-start $CONFLUENT_HOME/etc/schema-registry/schema-registry.properties
