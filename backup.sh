#!/bin/bash

# Variables
directory="/home/ubuntu/project1"
backup_dir="/home/ubuntu/backups"
s3_bucket="s3://your-s3-bucket-name"
name=$(date +"%Y-%m-%d_%H-%M")
backup_folder="$backup_dir/$name"

# Create backup directory
mkdir -p "$backup_folder"

# Move log files to the backup directory
for file in "$directory"/*; do
    extension="${file##*.}"
    if [ "$extension" = "log" ]; then
        mv "$file" "$backup_folder"
    else
        continue
    fi
done

# Upload the backup directory to S3
aws s3 cp "$backup_folder" "$s3_bucket/$name" --recursive

# Check if the upload was successful
if [ $? -eq 0 ]; then
    echo "Backup files have been successfully uploaded to S3."
else
    echo "There was an error uploading backup files to S3."
fi

# Optional: Clean up local backup folder after successful upload
# rm -rf "$backup_folder"
