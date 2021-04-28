#!/bin/sh
echo "Install minilocale files"
IP=hdfreaks.cc
ping -c 1 $IP  > /dev/null 2>&1

if [ $? == 0 ]
	then
		echo
		opkg update
		echo
		opkg install --force-reinstall minilocale
		echo
		echo "please restart enigma now"
		echo
	else
		echo
		echo "sorry ... update failed ... is you box online?"
		echo
fi

exit 0
