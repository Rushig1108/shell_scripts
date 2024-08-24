#!/bin/bash

# Usage: ./log_parser.sh <log_file> <log_type> [output_file]
# Example: ./log_parser.sh application.log ERROR output.txt

log_file="$1"
log_type="${2:-ERROR}"          # Default to ERROR if not specified
output_file="${3:-error.txt}"   # Default to error.txt if not specified

# Check if the log file is a compressed file (.gz)
if [[ "$log_file" == *.gz ]]; then
    log_content=$(zcat "$log_file")
else
    log_content=$(cat "$log_file")
fi

# Extract relevant log entries and contextual lines before/after the error
echo "Parsing log file: $log_file for log type: $log_type"
echo "Saving results to: $output_file"
echo -e "\n=== Log Summary ===" > "$output_file"

# Count and extract the log types
count=$(echo "$log_content" | grep -i "$log_type" | wc -l)
echo "$log_type occurrences: $count" >> "$output_file"

# Extract log entries with contextual lines (e.g., 2 lines before and after)
echo -e "\n=== Log Entries ===" >> "$output_file"
echo "$log_content" | grep -i -B 2 -A 2 "$log_type" | awk -F'[][]' '{print "Log type:", "'$log_type'", "at", $2 ":", $NF}' >> "$output_file"

echo "Log parsing completed. Summary and details are available in: $output_file"


