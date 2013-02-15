#!/bin/sh

if [ -f /usr/local/browser/browser ]; then 
	echo "HbbTV Browser found ... remove ET9x00 HbbTV"
	echo
	opkg remove enigma2-plugin-extensions-et-hbbtv
	echo
	echo "done"
	echo
	df -h | grep rootfs
	echo
else
	echo "HbbTV Browser not found ... install ET9x00 HbbTV"
	echo
	opkg install enigma2-plugin-extensions-et-hbbtv
	echo
	echo "done"
	echo
	df -h | grep rootfs
	echo
fi
exit 0 
