#!/bin/bash

function disableFirewall {
	echo "disabling firewall"
	ufw disable
}

echo "setup ubuntu"

disableFirewall
