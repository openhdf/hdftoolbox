#!/bin/sh

echo
echo "####################### running HDFreaks autostart scripts ####################### "
echo

##set temp output file
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

##use transponder or ntd date and time
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
#echo
#mediaportal=`opkg list-installed | grep extensions-mediaportal | cut -d" " -f1`
#if [ -z $mediaportal ]; then
#	echo "mediaportal is currently not installed"
#else
#	IP=hdfreaks.cc
#	ping -c 1 $IP  > /dev/null 2>&1
#		if [ $? == 0 ]; then
#			echo -n "box online ... "
#				if [ -f /usr/lib/enigma2/python/Plugins/Extensions/MediaPortal/skins/weed_EvoBlue/haupt_Screen.xml ]; then
#					echo "mediaportal skins are installed ... nothing to do"
#				else
#					echo -n "missing mediaportal skin ... install now"
#					opkg install --force-reinstall enigma2-plugin-skins-mediaportal > /dev/null 2>&1
#					echo " ... done"
#				fi
#		else
#			echo "box offline"
#		fi
#fi

##remove old videomode if new screen videomode is installed
echo
videomode=`opkg list-installed | grep systemplugins-videomode | cut -d" " -f1`
if [ -z $videomode ]; then
	echo "no old videomode found ... nothing to do"
else
	if [ -f /usr/lib/enigma2/python/Screens/VideoMode.pyo ]; then
		echo "remove old videomode version"
		opkg remove --force-depends enigma2-plugin-systemplugins-videomode > /dev/null 2>&1
		rm -fr /usr/lib/enigma2/python/Plugins/SystemPlugins/Videomode/ > /dev/null 2>&1
	else
		echo "no old videomode found ... nothing to do"
	fi
fi



echo