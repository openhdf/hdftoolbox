#!/bin/sh

echo -e "\nrecreate resolv.conf"

if [ -f /etc/resolv.conf ]; then
	echo -e "\n/etc/resolv.conf found ... remove and recreate\n"
	cp /etc/resolv.conf /etc/resolv.conf.backup
	rm -f /etc/resolv.conf
	cp /etc/resolv.conf.backup /etc/resolv.conf
	rm -f /etc/resolv.conf.backup
	echo -e "\ndone"
	sync
	echo
	echo "please reboot your STB now"
	sleep 4
	echo
else
	echo -e "no /etc/resolv.conf found\n"
fi
exit 0
