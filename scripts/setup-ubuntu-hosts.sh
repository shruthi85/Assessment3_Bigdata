#!/bin/bash

TOTAL_NODES=3

while getopts t: option
do
	case "${option}"
	in
		t) TOTAL_NODES=${OPTARG};;
	esac
done

function setupHosts {
	echo "modifying /etc/hosts file"
	for i in $(seq 1 $TOTAL_NODES)
	do 
		entry="10.0.2.4${i} node${i}"
		echo "adding ${entry}"
		echo "${entry}" >> /etc/nhosts
	done
	#cat /etc/hosts >> /etc/nhosts
	echo "127.0.0.1   localhost " >> /etc/nhosts
	cp /etc/nhosts /etc/hosts
	rm -f /etc/nhosts
    sudo ssh-keygen -t rsa -P '' -f /home/vagrant/.ssh/id_rsa
    cat /home/vagrant/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
    sudo chown vagrant /home/vagrant/.ssh/id_rsa
    sudo chmod 400 /home/vagrant/.ssh/id_rsa
	
}


echo "setup ubuntu hosts file"
setupHosts