#!/bin/sh

echo
echo "Please wait ... searching for updates"
opkg update > /dev/null 2>&1
echo
upgrades=`opkg list-upgradable`
opkg list-upgradable > /etc/last-upgrades-git.log
lines=`cat /etc/last-upgrades-git.log | wc -l`
if [ -z "$upgrades" ]; then
	echo "Nothing to upgrade at this point"
	echo
else
	echo
	echo
	echo "There are $lines updates available in /etc/last-upgrades-git.log"
	sleep 1
	echo "Please wait ... update is starting now"
	sleep 1
	echo "Don't stop this, close the windows or switch off your box!"
	sleep 1
	echo "Update is done, if you can close this windows with OK button"
	echo
	opkg upgrade > /dev/null 2>&1
	echo
	echo
	echo "Update Done ... Please reboot your Box now!"
	echo
	echo
fi

exit 0
