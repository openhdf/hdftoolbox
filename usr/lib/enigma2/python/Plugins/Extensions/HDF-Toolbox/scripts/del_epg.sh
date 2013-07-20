#!/bin/sh

echo
echo "find and destroy epg.dat"
export epgfilename=`find / -name epg.dat`

if [ -f "$epgfilename" ]; then
	echo "found epg = $epgfilename"
	echo "delete epg & restart enigma"
	rm -f $epgfilename
	echo "please wait ..."
	sleep 3
	init 4
	sleep 1
	init 3
else
	echo "no epg file found"
fi

echo
exit 0   
