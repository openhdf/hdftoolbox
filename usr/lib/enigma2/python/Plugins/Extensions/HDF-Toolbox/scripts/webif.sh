#!/bin/sh

cd /tmp
echo "Download and install update"

if [ `cat /proc/stb/info/chipset` = bcm7405 ]; then
	echo -e "\nBoxtype et9000\n"
	wget http://addons.hdfreaks.cc/et9000/webif.tar.gz
		if [ -f /tmp/webif.tar.gz ]; then
		echo -e "\nextract files"
		cd /
		tar xzvf /tmp/webif.tar.gz > /dev/null 2>&1
		rm -f /tmp/webif.tar.gz > /dev/null 2>&1
		echo -e "\nUpdate Done ... Please reboot your Box now"\!"\n"
fi
fi

if [ `cat /proc/stb/info/chipset` = 7335 ]; then
	echo -e "\nBoxtype vuduo\n"
	wget http://addons.hdfreaks.cc/vuduo/webif.tar.gz
		if [ -f /tmp/webif.tar.gz ]; then
		echo -e "\nextract files"
		cd /
		tar xzvf /tmp/webif.tar.gz > /dev/null 2>&1
		rm -f /tmp/webif.tar.gz > /dev/null 2>&1
		echo -e "\nUpdate Done ... Please reboot your Box now"\!"\n"
fi
fi

exit 0
