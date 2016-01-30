#!/bin/sh

echo -e "\nAutoupdate Multiplex Update"

if [ -f /etc/enigma2/.transponderupdate ]; then 
	echo
	rm /etc/enigma2/.transponderupdate
	echo -e "... is now OFF\n"
else
	echo
	touch /etc/enigma2/.transponderupdate
	echo -e "... is now ON ...\ntry to receive time/date from channel on every bootup" 
	/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/scripts/autostart.sh
fi
exit 0 
