#!/bin/bash

SSH_USER=centos
IP_ADDRESS=$(cat inventory | tail -n 1)
PKI_PRIVATE_PEM=/home/medined/Downloads/pem/david-va-oit-cloud-k8s.pem

if [ -z $AWS_ACCESS_KEY_ID ]; then
  echo "Define AWS_ACCESS_KEY_ID."
  exit
fi
if [ -z $AWS_SECRET_ACCESS_KEY ]; then
  echo "Define AWS_SECRET_ACCESS_KEY."
  exit
fi
if [ -z $AWS_SSH_KEY_NAME ]; then
  echo "Define AWS_SSH_KEY_NAME."
  exit
fi
if [ -z $AWS_DEFAULT_REGION ]; then
  echo "Define AWS_DEFAULT_REGION."
  exit
fi

export ANSIBLE_HOST_KEY_CHECKING=false

time python3 \
  $(which ansible-playbook) \
  -i "$IP_ADDRESS," \
  -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  -e AWS_SSH_KEY_NAME=$AWS_SSH_KEY_NAME \
  -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
  --private-key $PKI_PRIVATE_PEM \
  -u $SSH_USER \
  playbook.01-infrastructure.yml | tee log-playbook.01-infrastructure.log
