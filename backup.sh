#!/bin/bash
directory="/home/ubuntu/project1"
name=$(date +"%Y-%m-%d_%H-%M")
mkdir "$name"


for file in "$directory"/*; do
        extension="${file##*.}"
        if [ "$extension" = "log" ]; then
                mv "$file" "$name"
        else
                continue
        fi
done

mv "$name" "/home/ubuntu/backups"

