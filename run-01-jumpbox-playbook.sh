#!/bin/bash

SSH_USER=centos
IP_ADDRESS=$(cat inventory | tail -n 1)
PKI_PRIVATE_PEM=/home/medined/Downloads/pem/david-va-oit-cloud-k8s.pem

export ANSIBLE_HOST_KEY_CHECKING=false

time python3 \
  $(which ansible-playbook) \
  -i "$IP_ADDRESS," \
  --private-key $PKI_PRIVATE_PEM \
  -u $SSH_USER \
  playbook.01-jumpbox.yml | tee log-playbook.01-jumpbox.log
