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
grep "=" /tmp/.ImageVersion |sed -e 's/ //' -e 's//"/' -e 's/$/"/g' > /tmp/.version
grep ^version /etc/image-version >> /tmp/.version
source /tmp/.version
cat $issuenetlogo | sed "s/#GETIMAGEVERSION/$getImageVersion/g;s/GETCURRENTBUILD/$version/g;s/#MACHINE/$getMachineBrand $getMachineName/g" >/etc/issue.net

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
