#!/bin/sh

cd /tmp
echo
echo "Download and install updates."
opkg update  > /dev/null 2>&1
echo
opkg list-upgradable
if [ -n $? ]; then
	echo
	echo "Nothing to upgrade at this point."
	echo
	echo
else
	echo
	echo "Please wait ... update is starting now."
	echo "Don't stop this, close the windows or switch off your box!"
	echo "Update is done, if you can close this windows with OK button."
	echo
	opkg upgrade > /dev/null 2>&1
	echo
	echo "Update Done ... Please reboot your Box now!"
	echo
	echo
fi

exit 0
