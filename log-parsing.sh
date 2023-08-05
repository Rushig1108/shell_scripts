#!/bin/bash

log_file="$1"
touch error.txt
output_file="error.txt"

# Search for error lines and extract timestamps
grep -i "error" "$log_file" | awk -F'[][]' '{print "Error at", $2 ":", $NF}' > "$output_file"

echo "Error lines with timestamps have been saved to: $output_file"

