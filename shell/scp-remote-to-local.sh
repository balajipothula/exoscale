#!/bin/bash

# Author      : BALAJI POTHULA <balaji.pothula@techie.com>,
# Date        : 31 August 2016,
# Description : Securely copy from remote server to local client.

readonly USR=ec2-user            # ec2-user        # ubuntu
readonly HOST=18.196.171.91      # 35.158.116.126  # 
readonly PORT=22                 # 22
readonly PEM=Lua.pem             # webapp.pem

readonly FILE_NAME=webapp.tar.gz # webapp.tar.gz

# Securely copying file(s) from remote server to local client.
scp -o CheckHostIP=no -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $(pwd)/$PEM -P $PORT $USR@$HOST:~/$FILE_NAME $(pwd)