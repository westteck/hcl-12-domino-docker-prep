#! /bin/bash

# run as root or sudo

if (( EUID != 0 )); then
   echo "You must be root to do this." 1>&2
   exit 100
fi

# user=your_limited_user
echo "What is the name of you limited user?"
read user

# update - upgrade system to start
apt update -y && apt upgrade -y

# Install docker

apt install wget ca-certificates curl gnupg lsb-release nano rkhunter -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

read -p "paused for a sec"

apt update

apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

apt update && apt upgrade -y
apt autoclean -y && apt autoremove -y

# install docker-compose

curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# install ctop, top for docker containers

wget https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-amd64 -O /usr/local/bin/ctop
chmod +x /usr/local/bin/ctop

#

# Create folders in prep to install hcl domino server using hcl domino-container script.
# https://github.com/HCL-TECH-SOFTWARE/domino-container
#

mkdir -p /local/github
mkdir /local/notesdata
mkdir /local/domino
mkdir -p /var/www/html # if you are setting up a webserver as well
adduser notes

# change owner of domino local volumes
chown notes:notes /local/notesdata
chown notes:notes /local/domino

cd /local/github
git clone https://github.com/HCL-TECH-SOFTWARE/domino-container.git
# cd domino-container
cd ~

#
# copy latest domino server for linux to /local/github/domino-container/software
# sftp
# as of the time of this writing it is 12.0.1, it needs two files.
#
# Domino_1201FP1_Linux.tar and Domino_12.0.1_Linux_English.tar from hcl netflex server.
# at prompt enter sftp, at sftp prompt enter: put local/path/file /remote/path/file
#
# Users and ssh keys setup. assumes root has ssh key setup for ssh login.

# adduser $user
# usermod -aG $user sudo notes docker
# 
# mkdir /home/$user/.ssh
# chowm $user:$user /home/$user/.ssh
# cp .ssh/authorized_keys /home/$user/.ssh/
# chown $user:$user /home/$user/.ssh/authorized_keys 
chmod 700 /home/$user/.ssh
chmod 600 /home/$user/.ssh/authorized_keys

## setup ssh banner and restary ssh service

echo 
"
---------------------------------------------------------- 
      All connections are monitored and recorded     
Disconnect IMMEDIATELY if you are not an authorized user!

                      _________-----_____
           _____------           __      ----_
    ___----             ___------              \
       ----________        ----                 \
                   -----__    |             _____)
                        __-                /     \
            _______-----    ___--          \    /)\
      ------_______      ---____            \__/  /
                   -----__    \ --    _          /\
                          --__--__     \_____/   \_/\
                                  ----|   /          |
                                      |  |___________|
                                      |  | ((_(_)| )_)
                                      |  \_((_(_)|/(_)
                                      \             (
                                       \_____________)

" > /etc/issue.net
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

echo 'Banner /etc/isue.net' >> /etc/ssh/sshd_config
systemctl restart ssh
echo 'if yo are here, then all went well.'
