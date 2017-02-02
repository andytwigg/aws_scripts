#!/bin/bash
# stop on error
set -e

CUDNN_FILE=cudnn-8.0-linux-x64-v5.1.tgz
SETUP_SCRIPT=setup_aws.sh

if [ -z ${AWS_HOST+x} ]; then echo "error: AWS_HOST variable not set"; exit 1; fi
if [ ! -f $CUDNN_FILE ]; then echo "error: $CUDNN_FILE not found"; exit 1; fi

echo "SCP to $AWS_HOST.."
scp -i ~/isdc.pem *.sh $CUDNN_FILE ubuntu@$AWS_HOST:~

echo "SSH and executing setup script.."
ssh -i ~/isdc.pem ubuntu@$AWS_HOST "bash $SETUP_SCRIPT"
