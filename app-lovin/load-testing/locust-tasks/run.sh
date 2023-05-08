#!/bin/bash

LOCUST="/usr/local/bin/locust"
LOCUS_OPTS="-f /locust-tasks/$TASK_SCRIPT"

echo "$LOCUST $LOCUS_OPTS"

$LOCUST $LOCUS_OPTS