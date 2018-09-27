#!/bin/bash
echo "DBG1"
ifconfig eth1 172.16.253.1 netmask 255.255.255.0
echo "DBG2"
sleep 5
echo "DBG3"
sshpass -p "odroid" scp -o StrictHostKeyChecking=no /opt/monroe/airscopefix.sh root@172.16.253.2:/home/odroid/airscope
echo "DBG4"
odroidname=$(sshpass -p "odroid" ssh -o StrictHostKeyChecking=no -R 8080:localhost:8080 root@172.16.253.2 'cat /etc/hostname')
echo "DBG5"
odroidfile=airscope_node_$odroidname
echo "DBG6"
sshpass -p "odroid" ssh -o StrictHostKeyChecking=no -R 8080:localhost:8080 root@172.16.253.2 'cd /home/odroid/airscope && ./airscope airscope_monroe_restful.conf & sh /home/odroid/airscope/airscopefix.sh' & nodejs /opt/monroe/nodejs_server/server.js
echo "DBG7"
sleep 50 & cp $odroidfile /monroe/results/
