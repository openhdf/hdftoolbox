#!/bin/sh
echo "IPTV Service Patcher 4097 <--> 5002"
echo
#echo "Check for installed and needed packages"
if ! opkg list-installed | egrep 'exteplayer3' >/dev/null; then
	echo "install exteplayer3"
	opkg install exteplayer3
fi

if ! opkg list-installed | egrep 'ffmpeg' >/dev/null; then
	echo "install ffmpeg"
	opkg install ffmpeg
fi

if ! opkg list-installed | egrep 'enigma2-plugin-systemplugins-serviceapp' >/dev/null; then
	echo "install serviceapp"
	opkg install enigma2-plugin-systemplugins-serviceapp
fi

echo
echo "Please reboot your box,"
echo "if you run this script the first time!"
echo
echo

if grep 5002 /etc/enigma2/userbouquet.iptv* >/dev/null; then
	echo "Set iptv services from 5002 to 4097"
	sed -i 's/5002/4097/' /etc/enigma2/userbouquet.iptv*
	wget -qO - http://127.0.0.1/web/servicelistreload?mode=0 > /dev/null 2>&1
	echo "All IPTV Boquets now patched to >4097< mode"
	echo
	echo
	exit 1
fi

if grep 4097 /etc/enigma2/userbouquet.iptv* >/dev/null; then
	echo "Set iptv services from 4097 to 5002"
	sed -i 's/4097/5002/' /etc/enigma2/userbouquet.iptv*
	wget -qO - http://127.0.0.1/web/servicelistreload?mode=0 > /dev/null 2>&1
	echo "All IPTV Boquets now patched to >5002< mode"
	echo
	echo
	exit 1
fi

exit 1
