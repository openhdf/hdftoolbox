#!/bin/sh

echo
echo "Please wait ... searching for updates."
opkg update > /dev/null 2>&1
echo
sleep 1
upgrades="$(opkg list-upgradable)"
sleep 1
if [ -z $upgrades ]; then
	echo "Nothing to upgrade at this point."
	echo
else
	echo
	echo
	echo "Please wait ... update is starting now."
	sleep 2
	echo "Don't stop this, close the windows or switch off your box!"
	sleep 2
	echo "Update is done, if you can close this windows with OK button."
	echo
	opkg upgrade > /dev/null 2>&1
	echo
	echo
	echo "Update Done ... Please reboot your Box now!"
	echo
	echo
fi

exit 0
