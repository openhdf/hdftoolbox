#!/bin/sh

echo
echo "find ddbootup and remove string"

if [ -f /etc/init.d/ddbootup ]; then
	echo
	echo "ddbootup found ... remove string and reboot"
	echo
	find /etc/init.d/ddbootup -type f -exec sed -i '/ln -s /d' {} \;
	echo
	echo "done"
	sync
	echo "please wait ... reboot stb"
	sleep 4
	reboot
	echo
else
	echo "no /etc/init.d/ddbootup found"
	echo
fi
exit 0
