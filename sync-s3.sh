#!/bin/sh
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <bucket-name> <env>"
  exit 1
fi
BUCKET_NAME=$1
aws s3 sync s3://$BUCKET_NAME/$env /usr/share/nginx/html