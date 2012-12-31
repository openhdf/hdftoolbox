#!/bin/sh
echo "Reinstall HDF-Toolbox"
IP=hdfreaks.cc
ping -c 1 $IP  > /dev/null 2>&1

if [ $? == 0 ]
	then
		echo
		echo "remove installed version"
		rm -fr /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/boxtypes/ > /dev/null 2>&1
		rm -fr /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/menu > /dev/null 2>&1
		rm -fr /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/scripts > /dev/null 2>&1
		rm -fr /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/main.cfg > /dev/null 2>&1
		echo "install new version from feed"
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
