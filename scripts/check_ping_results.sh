#!/bin/bash

log_file="./ping_results/aggregated.log"
output="{}"

while IFS= read -r line
do
  if [[ "$line" == *"Results from"* ]]; then
    vm=$(echo "$line" | awk '{print $3}')
  elif [[ "$line" == *"3 packets transmitted"* ]]; then
    if [[ "$line" == *"0 received"* ]]; then
      result="FAIL"
    else
      result="PASS"
    fi
    output=$(jq --arg vm "$vm" --arg result "$result" '. + {($vm): $result}' <<< "$output")
  fi
done < "$log_file"

echo "$output"