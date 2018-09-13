#!/bin/sh

echo
echo "####################### running HDFreaks autostart scripts ####################### "
echo

##set temp output file
cat /proc/stb/info/boxtype /proc/version > /tmp/hdf.txt
echo "" >> /tmp/hdf.txt
cat /etc/version >> /tmp/hdf.txt
echo "" >> /tmp/hdf.txt
cat /proc/stb/info/chipset >> /tmp/hdf.txt
echo "" >> /tmp/hdf.txt
cat /proc/cpuinfo >> /tmp/hdf.txt

#check image version and write to issue.net
issuenetlogo=/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/issue.net_logo
grep 'getImageVersion\|getMachineBrand\|getMachineName' /tmp/.ImageVersion | sed "s/ \= /='/;s/$/'/"  > /tmp/.version
grep ^imageversion /etc/image-version >> /tmp/.version
source /tmp/.version
cat $issuenetlogo | sed "s/#GETIMAGEVERSION/$getImageVersion/g;s/GETCURRENTBUILD/$imageversion/g;s/#MACHINE/$getMachineBrand $getMachineName/g" >/etc/issue.net

#check spinner symlink
ln -fs /usr/share/enigma2/spinner/ /usr/share/enigma2/skin_default/.

#check ld-linux symlink
python /usr/lib/enigma2/python/BoxBrandingTest.pyo | sed 's/<$//g;s/ /_/g' > /tmp/boxbranding.cfg
if grep -Eqs 'cortexa15hf-neon-vfpv4' /tmp/boxbranding.cfg; then
	ln -fs /lib/ld-linux-armhf.so.3 /lib/ld-linux.so.3
fi

##create iptv symlinks to /usr/scripts/ for cronjobs
echo "check scripts and create symlinks"
[ -d /usr/scripts ] || mkdir /usr/scripts
rm -f /usr/scripts/IPTV_*
cp /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/e2scripts/* /usr/scripts/
chmod -R 755 /usr/scripts

#check mediaportal skins
if [ -d /usr/lib/enigma2/python/Plugins/Extensions/MediaPortal ]; then
	if [ -d /usr/lib/enigma2/python/Plugins/Extensions/MediaPortal/skins_1080/XionHDF ]; then
		echo "MP skins are currently installed"
	else
		opkg update
		opkg install mediaportal-skins --force-reinstall
	fi
fi

#check iptvplayer addons
if [ -d /usr/lib/enigma2/python/Plugins/Extensions/IPTVPlayer ]; then
	if [ -e /usr/lib/enigma2/python/Plugins/Extensions/IPTVPlayer/hosts/hostXXX.py ]; then
		echo "IPTV Player addons are currently installed"
	else
		opkg update
		opkg install iptv-player-xxx --force-reinstall
	fi
fi

# check streamlinkserver
if grep ^config.usage.streamlinkserver=true /etc/enigma2/settings >/dev/null; then
	if [ -e /usr/sbin/streamlinksrv ]; then
		echo "streamlinksrv installed"
	else
		opkg update
		opkg install enigma2-plugin-extensions-streamlinkserver
	fi
fi
if [ -e /usr/sbin/streamlinksrv ]; then
	if grep ^config.usage.streamlinkserver=true /etc/enigma2/settings >/dev/null; then
		chmod 755 /usr/sbin/streamlinksrv 
		/etc/rc3.d/S50streamlinksrv start
	else
		/etc/rc3.d/S50streamlinksrv stop
		chmod 644 /usr/sbin/streamlinksrv
	fi
fi

# install picons after flash
FREEsize=`df -k /usr/ | awk '/[0-9]%/ {print $4}'`
if [ -f /usr/share/enigma2/picon/1_0_19_EF74_3F9_1_C00000_0_0_0.png ] >/dev/null; then
	echo "default HDF picons already installed"
else
	if grep ^config.usage.hdfpicon=false /etc/enigma2/settings >/dev/null; then
		echo "HDF picons not wanted"
	else
		echo "installing HDF default picons"
			if [ "10576" -gt "$FREEsize" ]; then
				echo "Piconsize 4MB is to big for your Flashsize with "$FREEsize"kb free"
			else
				opkg update
				opkg install enigma2-plugin-picons-default-hdf
			fi
	fi
fi
