#!/bin/sh

if [ -f /usr/local/browser/browser ]; then 
	echo opkg list-installed | grep webbrowser
	echo
	echo "HbbTV Browser found ... remove ETXx00 HbbTV"
	echo
	opkg remove enigma2-plugin-extensions-et-hbbtv
	echo
	echo "done"
	sync
	echo
	df -h | grep rootfs
	echo
else
	echo "HbbTV Browser not found ... install ETXx00 HbbTV"
	echo
	freespace=`df -h | grep rootfs | df -h | grep rootfs | cut -c 46-47`
	freeneeded=10
	if [ $freespace -ge $freeneeded ]; then
		opkg install enigma2-plugin-extensions-et-hbbtv
		echo "done"
	else
		echo "Sorry not enough space in flash to install Browser"
	fi
	echo
	sync
	echo
	df -h | grep rootfs
	echo
fi
exit 0 
