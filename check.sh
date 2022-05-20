#! /bin/bash

echo 'testing rkhunter config
rkhunter -C
read 

echo 'test ufw'
ufw status verbose
read
