#!/bin/sh

echo
echo "Please wait ... upgrading HDF version ..."
rm -f /var/lib/opkg/lists/*
echo "change feed version"
find /etc/opkg/*-feed.conf -type f -exec sed -i 's!V4/!V4.1/!' {} \;
echo "change telnet version"
find /etc/issue.net -type f -exec sed -i 's/V4 ~/V4.1 ~/' {} \;
opkg update > /dev/null 2>&1
echo
upgrades=`opkg list-upgradable`
opkg list-upgradable > /etc/last-upgrades-git.log
lines=`cat /etc/last-upgrades-git.log | wc -l`
if [ -z "$upgrades" ]; then
	echo "Nothing to upgrade at this point."
	echo
	wget -q -O /tmp/.message.txt "http://127.0.0.1/web/message?text=Nothing%20to%20update%20at%20this%20point%20...&type=2" &  > /dev/null 2>&1 
else
	echo
	echo "There are $lines updates available in /etc/last-upgrades-git.log."
	echo
	sleep 1
	echo "Please wait ... upgrade in progress."
	sleep 1
	echo "Don't stop this, close the windows or switch off your box!"
	sleep 1
	echo
	opkg remove --force-depends enigma2-plugin-systemplugins-osd3dmodsetup > /dev/null 2>&1
	sleep 1
	opkg upgrade > /dev/null 2>&1
	echo "remove openhdf-version-info - old version"
	sleep 1
	opkg remove --force-depends openhdf-version-info > /dev/null 2>&1
	echo "install openhdf-version-info - new version"
	sleep 1
	opkg install openhdf-version-info > /dev/null 2>&1
	echo "install oe-alliance-branding - new version"
	sleep 1
	opkg remove --force-depends oe-alliance-branding > /dev/null 2>&1
	sleep 1
	opkg install oe-alliance-branding > /dev/null 2>&1
	echo "remove openhdf-enigma2 - old version"
	sleep 1
	opkg remove --force-depends enigma2	> /dev/null 2>&1
	echo "install openhdf-enigma2 - new version"
	sleep 1
	opkg install enigma2 > /dev/null 2>&1
	echo
	echo "Upgrade Done ... Your box is now launching new!"
	echo
	echo
	wget -q -O /tmp/.message.txt "http://127.0.0.1/web/message?text=Update%20done%20...%20please%20wait%20...%20Your%20STB%20reboot%20now%20...&type=2" &  > /dev/null 2>&1
	sleep 8
	reboot
fi

exit 0
