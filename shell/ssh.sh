#!/bin/bash

# Author      : BALAJI POTHULA <balaji.pothula@techie.com>,
# Date        : 31 August 2016,
# Description : Remote Server SSH Login.

# ssh-keygen -q -N '' -m pem -t rsa -b 4096 -C balaji.pothula@techie.com -f $(pwd)/webapp && mv $(pwd)/webapp $(pwd)/webapp.pem && chmod 400 $(pwd)/webapp.pem

readonly USR=ec2-user            # ec2-user # ubuntu
readonly HOST=18.196.171.91      # 35.158.116.126 #
readonly PORT=22                 # 22
readonly PEM=Lua.pem             # EC2.pem # webapp.pem

ssh -o ServerAliveInterval=60 -o ServerAliveCountMax=30 -o CheckHostIP=no -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $(pwd)/$PEM $USR@$HOST -p $PORT