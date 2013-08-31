#!/bin/sh

echo
echo "recreate resolv.conf"

if [ -f /etc/resolv.conf ]; then 
	echo
	echo "/etc/resolv.conf found ... remove and recreate"
	echo
	cp /etc/resolv.conf /etc/resolv.conf.backup
	rm -f /etc/resolv.conf
	cp /etc/resolv.conf.backup /etc/resolv.conf
	rm -f /etc/resolv.conf.backup
	echo
	echo "done"
	sync
	echo
	echo "please reboot your STB now"
	sleep 4
	echo
else
	echo "no /etc/resolv.conf found"
	echo
fi
exit 0 
