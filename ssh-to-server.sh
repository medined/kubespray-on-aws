#!/bin/bash

IP_ADDRESS=$(cat inventory | tail -n 1)
ssh centos@$IP_ADDRESS
