#!/bin/sh

upgrades=`opkg list-upgradable`
opkg list-upgradable > /etc/last-upgrades-git.log
lines=`cat /etc/last-upgrades-git.log | wc -l`
	
echo
if [ -f "/var/lib/opkg/.status" ]; then
	echo "The update function is currently disabled."
	echo
else
	echo "Please wait ... searching for updates ..."
	rm -f /var/lib/opkg/lists/* > /dev/null 2>&1
	rm -f /var/lib/opkg/openhdf* > /dev/null 2>&1
	opkg update > /dev/null 2>&1
	echo
	if [ -z "$upgrades" ]; then
		echo "Nothing to upgrade at this point."
		echo
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
	fi
fi

exit 0
