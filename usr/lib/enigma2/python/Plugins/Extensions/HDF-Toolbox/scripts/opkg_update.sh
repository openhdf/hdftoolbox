#!/bin/sh

upgrades=`opkg list-upgradable`
echo
echo "... update packages from feed ..."
opkg update
sleep 1
opkg update > /dev/null 2>&1
opkg list-upgradable > /etc/last-upgrades-git.log
sleep 1
opkg list-upgradable > /etc/last-upgrades-git.log
sleep 1
lines=`cat /etc/last-upgrades-git.log | wc -l`

echo
if [ -f "/var/lib/opkg/.status" ]; then
	echo "The update function is currently disabled."
	echo
else
	echo "Please wait ... searching for updates ..."
	rm -f /var/lib/opkg/lists/* > /dev/null 2>&1
	rm -f /var/lib/opkg/openhdf* > /dev/null 2>&1
	sleep 1
	opkg update
	sleep 1
	opkg update > /dev/null 2>&1
	sleep 1
	echo
	if [ -z "$upgrades" ]; then
		echo "Nothing to upgrade at this point."
		echo
	else
		echo
		echo "There are $lines updates available in /etc/last-upgrades-git.log."
		echo
		echo "Please wait ... update is starting now."
		echo "Don't stop this, close the windows or switch off your box!"
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
