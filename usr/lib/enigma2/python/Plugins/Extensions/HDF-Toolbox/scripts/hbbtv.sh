#!/bin/sh

if [ -x /usr/local/NXBrowser/launcher ]; then 
	echo
	/usr/local/NXBrowser/launcher stop > /dev/null 2>&1
	chmod 644 /usr/local/NXBrowser/launcher
	echo "HbbTV is now disabled."
	echo "Please restart Enigma now."
	echo
	echo
else
	echo
	chmod 755 /usr/local/NXBrowser/launcher
	echo "HbbTV is now enabled."
	echo "Please restart Enigma now."
	echo
	echo
fi
exit 0 
