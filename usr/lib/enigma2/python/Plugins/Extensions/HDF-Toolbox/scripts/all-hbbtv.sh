#!/bin/sh

line=$(grep -e et4000 -e et8000 -e et10000 /etc/enigma2/boxinformations)
boxtype=$(grep getBoxType /etc/enigma2/boxinformations | cut -d "=" -f 2)
echo Boxtype =$boxtype

if [[ -n "$line" ]]
then
	if [ -f /usr/local/NXBrowser/launcher ]; then
		echo
		echo -n "HbbTV Browser found ... remove from$boxtype"
		opkg remove --force-depends enigma2-plugin-extensions-newxtrend-hbbtv > /dev/null 2>&1
		echo " ... done"
		echo "please reboot your$boxtype now"
		sync
		df -h | grep /usr
		echo
	else
		echo
		echo "HbbTV Browser not found ... install HbbTV for$boxtype"
		#freespace=`df -h | grep rootfs | df -h | grep rootfs | cut -c 46-47`
		freespace=`df | awk '/rootfs/ {print $4}'`
		freespace2=`df | awk '/usr/ {print $4}'`
		freeneeded=10000
		echo
		if [ $freespace -ge $freeneeded ]; then
			echo "$freespace kB available on ubi0:rootfs. $freeneeded kB are needed"
			echo
			echo -n "please wait"
			opkg install enigma2-plugin-extensions-newxtrend-hbbtv > /dev/null 2>&1
			echo " ... done"
			echo "please reboot your$boxtype now"
		elif [ $freespace2 -ge $freeneeded ]; then
			echo "$freespace2 kB available on /usr. $freeneeded kB are needed"
			echo
			echo -n "please wait"
			opkg install enigma2-plugin-extensions-newxtrend-hbbtv > /dev/null 2>&1
			echo " ... done"
			echo "please reboot your$boxtype now"
		else
			echo "You need $freeneeded kB in your Flash available. But it is only $freespace kB free"
		fi
		sync
		echo
		df -h | grep /usr
		echo
	fi
else
	if [ -f /usr/local/hbb-browser/launcher ]; then
		echo
		echo -n "HbbTV Browser found ... remove from$boxtype"
		opkg remove --force-depends enigma2-plugin-extensions-hbbtv vuplus-opera-browser-util vuplus-opera-dumpait enigma2-hbbtv-util > /dev/null 2>&1
		echo " ... done"
		echo "please reboot your$boxtype now"
		sync
		df -h | grep /usr
		echo
	else
		echo
		echo "HbbTV Browser not found ... install HbbTV for$boxtype"
		#freespace=`df -h | grep rootfs | df -h | grep rootfs | cut -c 46-47`
		freespace=`df | awk '/rootfs/ {print $4}'`
		freespace2=`df | awk '/usr/ {print $4}'`
		freeneeded=10000
		echo
		if [ $freespace -ge $freeneeded ]; then
			echo "$freespace kB available on ubi0:rootfs. $freeneeded kB are needed"
			echo
			echo -n "please wait"
			opkg install enigma2-plugin-extensions-hbbtv > /dev/null 2>&1
			echo " ... done"
			echo "please reboot your$boxtype now"
		elif [ $freespace2 -ge $freeneeded ]; then
			echo "$freespace2 kB available on /usr. $freeneeded kB are needed"
			echo
			echo -n "please wait"
			opkg install enigma2-plugin-extensions-hbbtv > /dev/null 2>&1
			echo " ... done"
			echo "please reboot your$boxtype now"
		else
			echo "You need $freeneeded kB in your Flash available. But it is only $freespace kB free"
		fi
		sync
		echo
		df -h | grep /usr
		echo
	fi
fi
exit 0
