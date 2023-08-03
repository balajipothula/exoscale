#!/bin/bash

# Author      : BALAJI POTHULA <balaji.pothula@techie.com>,
# Date        : 31 August 2016,
# Description : Securely copy from local client to remote server.

readonly USR=ec2-user            # ec2-user        # ubuntu
readonly HOST=18.196.171.91      # 35.158.116.126  # 
readonly PORT=22                 # 22
readonly PEM=Lua.pem             # webapp.pem

# Securely copying file(s) from local client to remote server.
scp -o CheckHostIP=no -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $(pwd)/$PEM -P $PORT $(pwd)/$LUA $USR@$HOST:~