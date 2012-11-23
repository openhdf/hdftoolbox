#!/bin/sh
echo "Download new version of HDF-Toolbox"
IP=hdfreaks.cc
ping -c 1 $IP  > /dev/null 2>&1
if [ $? == 0 ]
	then
		wget -q http://addons.hdfreaks.cc/feeds/enigma2-plugin-extensions-hdftoolbox_v5_all.ipk -O /tmp/enigma2-plugin-extensions-hdftoolbox_v5_all.ipk
		echo
		echo "Download complete"
		echo
	else
  		echo "Sorry ... Update failed"
fi;

if [ -f /tmp/enigma2-plugin-extensions-hdftoolbox_v5_all.ipk ]; then 
	rm -fr /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/boxtypes/ > /dev/null 2>&1
	rm -fr /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/menu > /dev/null 2>&1
	rm -fr /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/scripts > /dev/null 2>&1
	rm -fr /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/main.cfg > /dev/null 2>&1
	opkg install /tmp/enigma2-plugin-extensions-hdftoolbox_v5_all.ipk
	#cp /usr/lib/enigma2/python/Plugins/Extensions/release.tgz /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/release.tgz
	#cd /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox
	#tar xzf release.tgz -C /
	#rm release.tgz
	rm /tmp/enigma2-plugin-extensions-hdftoolbox_v5_all.ipk
	date > /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/.lastupdate.log
echo
echo "please reboot enigma now"
echo
else
	echo "sorry there is a problem"
fi
exit 0 
