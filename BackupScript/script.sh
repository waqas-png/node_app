#!/bin/bash

# Define variables
BACKUP_SOURCE="/root/node_app"  
BACKUP_DEST="/backup"       
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="backup_$TIMESTAMP.tar.gz"
S3_BUCKET="s3://s3-backup-file-assignment"  # You can Change to your S3 bucket


mkdir -p $BACKUP_DEST
echo "Creating backup of $BACKUP_SOURCE..."
tar -czf $BACKUP_DEST/$BACKUP_FILE $BACKUP_SOURCE

# Simulate S3 upload
if [ -f "$BACKUP_DEST/$BACKUP_FILE" ]; then
    echo "Backup created: $BACKUP_DEST/$BACKUP_FILE"
    echo "Uploading backup to $S3_BUCKET..."
    aws s3 cp $BACKUP_DEST/$BACKUP_FILE $S3_BUCKET
    echo "Upload successful: $S3_BUCKET/$BACKUP_FILE"
else
    echo "Backup failed!"
    exit 1
fi

echo "Backup process completed!"