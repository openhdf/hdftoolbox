#!/bin/sh

echo
echo "find and destroy epg.dat"
export epgfilename2=`find /media/hdd/ -name epg.dat`
export epgfilename=`find /etc/ -name epg.dat`
echo $epgfilename
echo $epgfilename2

if [ -f "$epgfilename" ]; then
	echo "found epg = $epgfilename"
	echo "delete epg & restart enigma"
	rm -f $epgfilename
	echo "please wait ..."
	sleep 3
	killall -9 enigma2
elif [ -f "$epgfilename2" ]; then
	echo "found epg = $epgfilename2"
	echo "delete epg & restart enigma"
	rm -f $epgfilename2
	echo "please wait ..."
	sleep 3
	killall -9 enigma2
else
	echo "no epg file found"
fi

echo
exit 0
