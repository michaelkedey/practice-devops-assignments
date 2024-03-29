#!/bin/bash

log_file="$HOME/logs.txt"

logdate=$(date +"%Y-%m-%d %H:%M:%S")

logmessage="Log entry at ${logdate}"

echo "$logmessage" >> "$log_file"

echo "log entry added successful"
