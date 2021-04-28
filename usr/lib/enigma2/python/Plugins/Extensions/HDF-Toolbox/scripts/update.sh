#!/bin/sh
echo "Reinstall HDF-Toolbox"
IP=hdfreaks.cc
ping -c 1 $IP  > /dev/null 2>&1

if [ $? == 0 ]
	then
		echo
		echo "install last version from feed"
		opkg install --force-reinstall enigma2-plugin-extensions-hdftoolbox > /dev/null 2>&1
		date > /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/.lastupdate.log
		echo "please restart enigma now"
		echo
	else
		echo
		echo "sorry ... update failed ... is you box online?"
		echo
fi

exit 0
