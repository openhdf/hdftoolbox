#!/bin/sh

cd /tmp
echo "Download and install update"

	echo
	echo "starting okgp update & upgrade"
    	opkg update > /dev/null 2>&1
		opkg upgrade
	echo
	cd /tmp
	echo "download & extract spinnerupdate"
	wget -q http://addons.hdfreaks.cc/feeds/enigma2-plugins-update-HDFreaks_SpinnerupdateET9x00.tar.gz
	echo
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
