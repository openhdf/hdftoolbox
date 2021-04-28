#!/bin/sh

if [ -x /usr/local/NXBrowser/launcher ]; then
	echo
	/usr/local/NXBrowser/launcher stop > /dev/null 2>&1
	chmod 644 /usr/local/NXBrowser/launcher
	echo -e "HbbTV is now disabled.\nPlease restart Enigma now.\n\n"
else
	echo
	chmod 755 /usr/local/NXBrowser/launcher
	echo -e "HbbTV is now enabled.\nPlease restart Enigma now.\n\n"
fi
exit 0
