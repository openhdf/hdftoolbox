#!/bin/sh

if [ -f /etc/.djmount ]; then
	echo
	/etc/init.d/djmount stop
	chmod 644 /etc/init.d/djmount
	rm -f /etc/.djmount
	echo -e "\ndjmount DLNA Client autostart is now OFF\n\n"
else
	echo
	chmod 755 /etc/init.d/djmount
	touch /etc/.djmount
	/etc/init.d/djmount start
	echo -e "\ndjmount DLNA Client autostart is now ON\nYou can find the UPNP/DLNA Server inside /media/upnp/\n\n"
fi
exit 0
