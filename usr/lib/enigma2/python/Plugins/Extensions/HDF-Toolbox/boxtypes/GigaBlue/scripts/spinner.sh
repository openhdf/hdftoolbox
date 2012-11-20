#!/bin/sh

cd /tmp
echo "Download and install update"
	echo
	echo "Boxtype GigaBlue"
	echo
	echo "starting okgp update & upgrade"
 	opkg update > /dev/null 2>&1
	opkg upgrade
	echo
	wget -q http://addons.hdfreaks.cc/feeds/enigma2-plugins-update-HDFreaks_SpinnerupdateGigaBlue.tar.gz
	echo
	echo "extract files"
	rm -f /usr/share/enigma2/skin_default/spinner/wait*.*
	cd /
	tar xzvf /tmp/enigma2-plugins-update-HDFreaks_SpinnerupdateGigaBlue.tar.gz > /dev/null 2>&1
	rm -f /tmp/enigma2-plugins-update-HDFreaks_SpinnerupdateGigaBlue.tar.gz > /dev/null 2>&1
	echo
	echo "Update Done ... Please reboot your Box now!"
	echo
exit 0 
