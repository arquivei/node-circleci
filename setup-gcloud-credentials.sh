#!/bin/sh

# Checks credentials file and project
if [  -z "$GCLOUD_KEYFILE" ]; then
    echo "Missing environment variable GCLOUD_KEYFILE"
    exit 1
elif [ -z "$GCLOUD_PROJECT" ];then
    echo "Missing environment variable GCLOUD_PROJECT"
    exit 1
fi

echo $GCLOUD_KEYFILE | base64 -d > ~/.gcloud-api-key.json
gcloud auth activate-service-account --key-file ~/.gcloud-api-key.json
gcloud config set project $GCLOUD_PROJECT
gcloud auth configure-docker --quiet
