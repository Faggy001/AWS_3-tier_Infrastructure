#!/bin/bash

# Configuration
BUCKET_NAME="groupb-terraform-state005"
OBJECT_KEY="example-folder/hello.txt"
LOCAL_FILE="/tmp/hello.txt"

# Write content to local file
echo "Hello from Xapic Group B Team!" > $LOCAL_FILE

# Upload to S3
aws s3 cp $LOCAL_FILE s3://$BUCKET_NAME/$OBJECT_KEY
if [ $? -eq 0 ]; then
    echo "Upload successful: s3://$BUCKET_NAME/$OBJECT_KEY"
else
    echo "Upload failed"
    exit 1
fi

# Download from S3
aws s3 cp s3://$BUCKET_NAME/$OBJECT_KEY /tmp/hello_downloaded.txt
if [ $? -eq 0 ]; then
    echo "Downloaded content:"
    cat /tmp/hello_downloaded.txt
else
    echo "Download failed"
    exit 1
fi