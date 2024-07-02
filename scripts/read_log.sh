#!/bin/bash

log_file="./ping_results/aggregated.log"
content=$(cat "$log_file")

jq -n --arg content "$content" '{"content": $content}'
