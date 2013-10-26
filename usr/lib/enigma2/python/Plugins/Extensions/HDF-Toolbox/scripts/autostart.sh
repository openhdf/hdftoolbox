#!/bin/sh

#set temp output file
rm /tmp/hdf.txt
touch /tmp/hdf.txt
cat /proc/stb/info/boxtype >> /tmp/hdf.txt
echo "" >> /tmp/hdf.txt
cat /proc/version >> /tmp/hdf.txt
echo "" >> /tmp/hdf.txt
less /etc/version >> /tmp/hdf.txt
echo "" >> /tmp/hdf.txt
cat /proc/stb/info/chipset >> /tmp/hdf.txt
echo "" >> /tmp/hdf.txt
cat /proc/cpuinfo >> /tmp/hdf.txt
####

if [ -f /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/scripts/dvbdate ]; then
	if [ -f /etc/enigma2/.transponderupdate ]; then
			echo "update time & date from multiplex"
			/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/scripts/dvbdate --set --force --timeout 60 &
			if [ $? == 0 ]; then
			echo "update done ..."
			echo
			else
			echo "update failed ... try again"
			/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/scripts/dvbdate --set --force --quiet --timeout 15 &
			echo "and the last try"
			echo
			/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/scripts/dvbdate --set --force --quiet --timeout 15 &
			echo
			fi
		else
		echo "auto timeupdate from multiplex deactivated"
	fi
else
	echo "no binary dvbdate found"
fi

##reinstall mediaportal skins after update
echo
mediaportal=`opkg list-installed | grep extensions-mediaportal | cut -d" " -f1`
if [ $mediaportal == enigma2-plugin-extensions-mediaportal ]; then
	echo "mediaportal is installed"
	IP=hdfreaks.cc
	ping -c 1 $IP  > /dev/null 2>&1
		if [ $? == 0 ]; then
			echo "box online"
				if [ -f /usr/lib/enigma2/python/Plugins/Extensions/MediaPortal/skins/weed_/haupt_Screen.xml ]; then
					echo "mediaportal skins are installed ... nothing to do"
				else
					echo "missing mediaportal skin ... install now"
					opkg install --force-reinstall enigma2-plugin-skins-mediaportal > /dev/null 2>&1
					echo "done"
				fi
		else
			echo "box offline"
		fi
else
	echo "mediaportal is currently not installed"
fi
