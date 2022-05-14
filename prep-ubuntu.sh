#!/bin/bash

#
#Create folders in prep to install hcl domino server using hcl domino-container script.
# https://github.com/HCL-TECH-SOFTWARE/domino-container
#
# Apps to install on clean server
# apt install wget git docker-cli docker-compose

sudo mkdir -p /local/github
sudo mkdir /local/notesdata
sudo mkdir /local/domino

adduser notes


chown notes:notes /local/notesdata
chown notes/notes /local/domino

cd /local/github
git clone https://github.com/HCL-TECH-SOFTWARE/domino-container.git
cd domino-container

#
#copy latest domino server for linux to /local/github/domino-container/software
# as of the time of this writing it is 12.0.1, it needs two files.
# Domino_1201FP1_Linux.tar and Domino_12.0.1_Linux_English.tar from hcl netflex server.
#
