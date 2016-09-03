#!/bin/sh

echo
echo "####################### running HDFreaks autostart scripts ####################### "
echo

##set temp output file
cat /proc/stb/info/boxtype > /tmp/hdf.txt
cat /proc/version >> /tmp/hdf.txt
echo "" >> /tmp/hdf.txt
less /etc/version >> /tmp/hdf.txt
echo "" >> /tmp/hdf.txt
cat /proc/stb/info/chipset >> /tmp/hdf.txt
echo "" >> /tmp/hdf.txt
cat /proc/cpuinfo >> /tmp/hdf.txt

#check image version and write to issue.net
imageversion=`grep ^getImageVersion /tmp/.ImageVersion | cut -d" " -f3`
imagebuild=`grep ^version /etc/image-version | cut -f2 -d=`
if ! grep "$imageversion build: $imagebuild" /etc/issue.net >/dev/null ;then
	sed -i "s|^~ HDFreaks Image.*|~ HDFreaks Image V$imageversion build: $imagebuild ~|" /etc/issue.net
fi

#check spinner symlink
if [ -L /usr/share/enigma2/skin_default/spinner ]; then
		echo "spinner symlink found"
	else
		echo "create spinner symlink"
		rm -fr /usr/share/enigma2/skin_default/spinner > /dev/null 2>&1
		ln -s /usr/share/enigma2/spinner/ /usr/share/enigma2/skin_default/
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
