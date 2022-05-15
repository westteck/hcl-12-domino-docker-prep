# hcl-12-domino-docker-prep
Get ubuntu 21.0.4, 22.0.4 server ready to install hcl domino-container.

This assumes a clean server, no users, no updates, totaly fresh install

The script installs the domino-container repo from hcl,
it installs a notes user and a limited user of your choice. 
it assumes you have loged into the server as root and you are using
ssh keys to do so.

It also installs ctop, a great tool for docker containers.

It sets up the folder structure needed for a standard domino install.

/local/github/domino-container
/local/notesdata
/local/domino

after completed the system needs to be restarted. Then the domino server
install files need to be uploaded.

The latest files as of May 2022 are
Domino_12.0.1_Linux_English.tar
and
Domino_1201FP1_Linux.tar

on your local machine, mine is a mac. I use sftp to transfer the files like this:

sftp
<sftp> put local/path/to/Domino_1201FP1_Linux.tar /local/github/domino-container/software
<sftp>  put local/path/to/Domino_12.0.1_Linux_English.tar /local/github/domino-container/software
<sftp> quit
  
  Now you are ready to begin the install. just follow the steps in the docs in the hcl repo:
  https://github.com/HCL-TECH-SOFTWARE/domino-container
  
  starting with "./build.sh domino" from the folder /local/github/domino-container
  domino when it is working in docker 
  
  I will also be installing some other docker containers.
  After this all works and you should be able to reach http://host and get the domino splash screen, 
  I will also setup portainer and Nginx Proxy Manager.
  
  good luck all.
  Eric
