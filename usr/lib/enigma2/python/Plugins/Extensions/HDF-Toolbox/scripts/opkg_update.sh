#!/bin/sh

echo
echo "Please wait ... searching for updates ..."
rm -f /var/lib/opkg/lists/*
opkg update > /dev/null 2>&1
echo
upgrades=`opkg list-upgradable`
opkg list-upgradable > /etc/last-upgrades-git.log
lines=`cat /etc/last-upgrades-git.log | wc -l`
if [ -z "$upgrades" ]; then
	echo "Nothing to upgrade at this point."
	echo
	#wget -q -O /tmp/.message.txt "http://127.0.0.1/web/message?text=Nothing%20to%20update%20at%20this%20point%20...&type=2" &  > /dev/null 2>&1 
else
	echo
	echo "There are $lines updates available in /etc/last-upgrades-git.log."
	echo
	sleep 1
	echo "Please wait ... update is starting now."
	sleep 1
	echo "Don't stop this, close the windows or switch off your box!"
	sleep 1
	echo "Update is done, if you can close this screen with OK button."
	echo
	opkg upgrade > /dev/null 2>&1
	cat /etc/last-upgrades-git.log
	echo
	echo
	echo "Update Done ... Please reboot your Box now!"
	echo
	echo
	#wget -q -O /tmp/.message.txt "http://127.0.0.1/web/message?text=Update%20done%20...%20please%20reboot%20your%20STB%20now%20...&type=2" &  > /dev/null 2>&1
fi

exit 0
