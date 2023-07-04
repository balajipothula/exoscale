#!/bin/bash

# Author      : BALAJI POTHULA <balaji@significo.com>,
# Date        : 31 August 2016,
# Description : Remote Server SSH Login.

# ssh-keygen -q -N '' -m pem -t rsa -b 4096 -C balaji@significo.com -f $HOME/balaji@significo.com && mv $HOME/balaji@significo.com $HOME/balaji@significo.com.pem && chmod 400 $HOME/balaji@significo.com.pem

readonly USR=ubuntu
readonly HOST=rstudio-mds.significo.dev
readonly PORT=22
readonly PEM=$HOME/balaji@significo.com.pem

ssh -o ServerAliveInterval=60 -o ServerAliveCountMax=30 -o CheckHostIP=no -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $PEM $USR@$HOST -p $PORT
