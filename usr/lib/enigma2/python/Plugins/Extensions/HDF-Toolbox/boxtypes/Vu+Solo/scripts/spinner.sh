#!/bin/sh

cd /tmp
	echo "start OpenHDF spinnerupdate"
	echo
	echo "starting okgp update & upgrade"
 	opkg update > /dev/null 2>&1
	opkg upgrade
	echo
	echo "download OpenHDF spinnerupdate"
	wget -q http://addons.hdfreaks.cc/feeds/enigma2-plugins-update-HDFreaks_SpinnerupdateOpenHDF.tar.gz
	echo
	echo "extract spinnerupdate"
	cd /
	tar xzvf /tmp/enigma2-plugins-update-HDFreaks_SpinnerupdateOpenHDF.tar.gz > /dev/null 2>&1
	rm -f /tmp/enigma2-plugins-update-HDFreaks_SpinnerupdateOpenHDF.tar.gz > /dev/null 2>&1
	echo
	echo "update done ... please reboot your Box now!"

exit 0 
