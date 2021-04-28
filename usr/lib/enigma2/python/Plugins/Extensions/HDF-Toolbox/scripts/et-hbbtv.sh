#!/bin/sh

if [ -f /usr/local/browser/browser ]; then
	echo opkg list-installed | grep webbrowser
	echo
	echo "HbbTV Browser found ... remove ETXx00 HbbTV"
	echo
	opkg remove enigma2-plugin-extensions-et-hbbtv enigma2-plugin-extensions-et-hbbtv-old > /dev/null 2>&1
	echo "done"
	sync
	echo
	df -h | grep /usr
	echo
else
	echo "HbbTV Browser not found ... install ETXx00 2.0.0 HbbTV"
	#freespace=`df -h | grep rootfs | df -h | grep rootfs | cut -c 46-47`
	freespace=`df | awk '/rootfs/ {print $4}'`
	freespace2=`df | awk '/usr/ {print $4}'`
	freeneeded=10000
	echo
	if [ $freespace -ge $freeneeded ]; then
		echo "$freespace kB available on ubi0:rootfs. $freeneeded kB are needed for installation of HbbTV"
		opkg install enigma2-plugin-extensions-et-hbbtv  > /dev/null 2>&1
		echo "done"
	elif [ $freespace2 -ge $freeneeded ]; then
		echo "$freespace2 kB available on /usr. $freeneeded kB are needed for installation of HbbTV"
		echo
		opkg install enigma2-plugin-extensions-et-hbbtv  > /dev/null 2>&1
		echo "done"
	else
		echo "You need $freeneeded kB in your Flash available. But it is only $freespace kB free"
	fi
	echo
	sync
	echo
	df -h | grep /usr
	echo
fi
exit 0
