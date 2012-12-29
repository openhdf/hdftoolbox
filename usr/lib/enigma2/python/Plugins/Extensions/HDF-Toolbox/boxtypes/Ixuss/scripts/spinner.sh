#!/bin/sh

cd /tmp
echo "Download and install update"

	echo
	echo "Boxtype Ixuss"
	echo
	echo "starting okgp update & upgrade"
 	opkg update > /dev/null 2>&1
	opkg upgrade
	echo
	wget -q http://addons.hdfreaks.cc/feeds/enigma2-plugins-update-HDFreaks_SpinnerupdateIxuss.tar.gz
	echo
	echo "extract files"
	cd /
	tar xzvf /tmp/enigma2-plugins-update-HDFreaks_SpinnerupdateIxuss.tar.gz > /dev/null 2>&1
	rm -f /tmp/enigma2-plugins-update-HDFreaks_SpinnerupdateIxuss.tar.gz > /dev/null 2>&1
	echo
	echo "Update Done ... Please reboot your Box now!"

exit 0 
