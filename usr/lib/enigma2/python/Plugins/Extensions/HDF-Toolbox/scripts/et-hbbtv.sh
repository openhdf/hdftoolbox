#!/bin/sh

if [ -f /usr/local/browser/browser ]; then 
	echo opkg list-installed | grep webbrowser
	echo
	echo "HbbTV Browser found ... remove ET9x00 HbbTV"
	echo
	opkg remove enigma2-plugin-extensions-et-webbrowser
	echo
	echo "done"
	sync
	echo
	df -h | grep rootfs
	echo
else
	echo "HbbTV Browser not found ... install ET9x00 HbbTV"
	echo
	freespace=`df -h | grep rootfs | df -h | grep rootfs | cut -c 46-47`
	freeneeded=10
	if [ $freespace -ge $freeneeded ]; then
		opkg enigma2-plugin-extensions-et-webbrowser
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
