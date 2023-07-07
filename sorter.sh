#!/bin/bash
directory="/home/ubuntu/project1"

for file in "$directory"/*; do
	extension="${file##*.}"
	if [ "$extension" = "txt" ]; then
		mv "$file" "/home/ubuntu/project1/text"
	elif [ "$extension" = "jpg" ]; then 
		mv "$file" "/home/ubuntu/project1/jpeg"
	else 
		continue
	fi
done 
