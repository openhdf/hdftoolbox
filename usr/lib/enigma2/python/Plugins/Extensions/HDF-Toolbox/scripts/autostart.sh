#!/bin/sh

echo
echo "####################### running HDFreaks autostart scripts ####################### "
echo

server=iptv.hdfreaks.cc
ping -c1 -W1 -q $server &>/dev/null
status=$( echo $? )
#echo $status
if [[ $status == 0 ]] ; then
	online="0"
	echo "HDFreaks Server reachable"
else
	online="1"
	echo "HDFreaks Server not reachable"
fi

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
echo "Check scripts and create some symlinks"
[ -d /usr/scripts ] || mkdir /usr/scripts
rm -f /usr/scripts/IPTV_*
cp /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/e2scripts/* /usr/scripts/
chmod -R 755 /usr/scripts

#check mediaportal skins
if [ -d /usr/lib/enigma2/python/Plugins/Extensions/MediaPortal ]; then
	if [ -d /usr/lib/enigma2/python/Plugins/Extensions/MediaPortal/skins_1080/XionHDF ]; then
		echo "MediaPortal skins are currently installed"
	else
		if [ $online == 0 ]; then
			opkg update
			opkg install mediaportal-skins --force-reinstall
		else
			echo "Server not available"
		fi
	fi
fi

#check iptvplayer addons
if [ -d /usr/lib/enigma2/python/Plugins/Extensions/IPTVPlayer ]; then
	if [ -e /usr/lib/enigma2/python/Plugins/Extensions/IPTVPlayer/hosts/hostXXX.py ]; then
		echo "IPTV Player addons are currently installed"
	else
		if [ $online == 0 ]; then
			opkg update
			opkg install enigma2-plugin-extensions-e2iplayer-xxx --force-reinstall
		else
			echo "Server not available"
		fi
	fi
fi

# check serviceapp
if grep ^config.usage.serviceapp=true /etc/enigma2/settings >/dev/null; then
	if [ -e /usr/lib/enigma2/python/Plugins/SystemPlugins/ServiceApp/serviceapp.so ]; then
		echo "ServiceApp is installed"
	else
		if [ $online == 0 ]; then
			opkg update
			echo "Remove ServiceHisilicon"
			opkg remove --force-depends enigma2-plugin-systemplugins-servicehisilicon
			opkg install enigma2-plugin-systemplugins-serviceapp
		else
			echo "Server not available"
		fi
	fi
fi
if ! grep ^config.usage.serviceapp /etc/enigma2/settings >/dev/null; then
	if [ -e /usr/lib/enigma2/python/Plugins/SystemPlugins/ServiceApp/serviceapp.so ]; then
		echo "ServiceApp is installed"
		opkg remove --force-depends enigma2-plugin-systemplugins-serviceapp
		if [ $online == 0 ]; then
			echo "install servicehisilicon again"
			opkg update
			opkg install enigma2-plugin-systemplugins-servicehisilicon
		else
			echo "Server not available"
		fi
	else
		echo "ServiceApp not installed"
	fi
fi

# check streamlinkserver
if grep ^config.usage.streamlinkserver=true /etc/enigma2/settings >/dev/null; then
	if [ -e /usr/sbin/streamlinksrv ]; then
		echo "Streamlinksrv is installed"
	else
		if [ $online == 0 ]; then
			opkg update
			opkg install enigma2-plugin-extensions-streamlinkserver
		else
			echo "Server not available"
		fi
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

# check clearmemlite
if grep ^config.usage.cleanmemlite=true /etc/enigma2/settings >/dev/null; then
	if [ -e /usr/lib/enigma2/python/Plugins/Extensions/ClearMem/plugin.py ]; then
		echo "clearmemlite installed"
	else
		if [ $online == 0 ]; then
			opkg update
			opkg install enigma2-plugin-extensions-clearmem-lite_1.0_all
		else
			echo "Server not available"
		fi
	fi
fi

# change minisatip port to 9090
if [ -e /etc/init.d/minisatip ]; then
	echo "copy minisatip startscript"
	cp /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/scripts/bootfiles/minisatip /etc/init.d/
	chmod -R 755 /etc/init.d/minisatip
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
				if [ $online == 0 ]; then
					opkg update
					opkg install enigma2-plugin-picons-default-hdf
				else
					echo "Server not available"
				fi
			fi
	fi
fi
