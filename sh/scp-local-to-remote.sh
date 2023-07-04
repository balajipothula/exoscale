#!/bin/bash

# Author      : BALAJI POTHULA <balaji.pothula@techie.com>,
# Date        : 31 August 2016,
# Description : SCP from Client to Remote Server.

readonly USR=ubuntu
readonly HOST=rstudio-mds.significo.dev
readonly PORT=22
readonly PEM=$HOME/balaji@significo.com.pem

readonly FILE=$HOME/webapp.tar.xz # $HOME/rstudio.tar.gz #

# Copying file(s) from local to remote.
scp -o CheckHostIP=no -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $PEM -P $PORT $FILE $USR@$HOST:~
