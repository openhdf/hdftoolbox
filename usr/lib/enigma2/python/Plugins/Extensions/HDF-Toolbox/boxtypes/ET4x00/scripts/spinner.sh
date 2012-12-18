#!/bin/sh

cd /tmp
echo "Download and install update"

if [ `cat /proc/stb/info/chipset` = bcm7405 ]; then 
	echo
	echo "Boxtype et9x00/et6x00"
	echo
	echo "starting okgp update & upgrade"
    	opkg update > /dev/null 2>&1
		opkg upgrade
	echo
	cd /tmp
	echo "download & extract spinnerupdate"
	wget -q http://addons.hdfreaks.cc/feeds/enigma2-plugins-update-HDFreaks_SpinnerupdateET9x00.tar.gz
	echo
	if [ -f /etc/opkg/et9x00-feed.conf ]; then
		echo "New et9x00 Image found"
	if [ -f /etc/opkg/et9000-feed.conf ]; then
	echo "Old et9000 Image found ... download HdmiCec.py from PLi Git"
	wget 'http://openpli.git.sourceforge.net/git/gitweb.cgi?p=openpli/enigma2;a=blob_plain;f=lib/python/Components/HdmiCec.py;hb=HEAD' -O /usr/lib/enigma2/python/Components/HdmiCec.py
	fi
	fi
	echo
	echo "extract files"
	cd /
	tar xzvf /tmp/enigma2-plugins-update-HDFreaks_SpinnerupdateET9x00.tar.gz > /dev/null 2>&1
	rm -f /tmp/enigma2-plugins-update-HDFreaks_SpinnerupdateET9x00.tar.gz > /dev/null 2>&1
	echo
	echo "Update Done ... Please reboot your Box now!"
	echo
fi

exit 0 
