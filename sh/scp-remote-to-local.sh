#!/bin/bash

# Author      : BALAJI POTHULA <balaji.pothula@techie.com>,
# Date        : 31 August 2016,
# Description : SCP from Remote Server to Client.

readonly USR=ubuntu
readonly HOST=rstudio-mds.significo.dev
readonly PORT=22
readonly PEM=$HOME/balaji@significo.com.pem

readonly FILE=webapp.tar.gz # rstudio.tar.gz #

# Copying file(s) from remote to local.
scp -o CheckHostIP=no -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $PEM -P $PORT $USR@$HOST:~/$FILE $HOME
