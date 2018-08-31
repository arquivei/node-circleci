#!/bin/sh

function print_usage {
    cat <<EOF
usage: $0 <PROFILE>

Setups credentials for aws

PROFILE:
    dev     Setups development credentials
    prod    Setups production credentials

Examples:
    $0 prod
    $0 dev
EOF
}

if [ $# -eq 0 ]; then
    echo "Missing profile!"
    print_usage
    exit 1
fi;

if [  -z "$AWS_CREDENTIALS" ]; then
    echo "Missing environment variable AWS_CREDENTIALS"
    exit 1
elif [ -z "$AWS_CONFIGS" ];then
    echo "Missing environment variable AWS_CONFIGS"
    exit 1
fi

mkdir -p ~/.aws
echo $AWS_CREDENTIALS | base64 -d > ~/.aws/credentials
echo $AWS_CONFIGS | base64 -d > ~/.aws/config
$(aws ecr get-login --region ${AWS_DEFAULT_REGION} --no-include-email --profile $1)
