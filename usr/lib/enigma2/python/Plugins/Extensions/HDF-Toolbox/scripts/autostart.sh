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

#check image version and write to issue.net
imageversion=`less /tmp/.ImageVersion | grep "getImageVersion" | cut -d" " -f3`
if [ $imageversion = "4.2" ]; then
	find /etc/issue.net -type f -exec sed -i 's/V5.1 ~/V4.2 ~/' {} \;
	find /etc/issue.net -type f -exec sed -i 's/V5.2 ~/V4.2 ~/' {} \;
	find /etc/issue.net -type f -exec sed -i 's/V5.3 ~/V4.2 ~/' {} \;
fi
if [ $imageversion = "5.1" ]; then
	find /etc/issue.net -type f -exec sed -i 's/V5.2 ~/V5.1 ~/' {} \;
	find /etc/issue.net -type f -exec sed -i 's/V4.2 ~/V5.1 ~/' {} \;
	find /etc/issue.net -type f -exec sed -i 's/V5.3 ~/V5.1 ~/' {} \;
fi
if [ $imageversion = "5.2" ]; then
	find /etc/issue.net -type f -exec sed -i 's/V5.1 ~/V5.2 ~/' {} \;
	find /etc/issue.net -type f -exec sed -i 's/V4.2 ~/V5.2 ~/' {} \;
	find /etc/issue.net -type f -exec sed -i 's/V5.3 ~/V5.2 ~/' {} \;
fi 
if [ $imageversion = "5.3" ]; then
	find /etc/issue.net -type f -exec sed -i 's/V5.1 ~/V5.3 ~/' {} \;
	find /etc/issue.net -type f -exec sed -i 's/V5.2 ~/V5.3 ~/' {} \;
	find /etc/issue.net -type f -exec sed -i 's/V4.2 ~/V5.3 ~/' {} \;
fi 
#check spinner symlink
if [ -L /usr/share/enigma2/skin_default/spinner ]; then
		echo "spinner symlink found"
	else
		echo "create spinner symlink"
		rm -fr /usr/share/enigma2/skin_default/spinner > /dev/null 2>&1
		ln -s /usr/share/enigma2/spinner/ /usr/share/enigma2/skin_default/
fi
	
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

##remove old videomode if new screen videomode is installed
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
