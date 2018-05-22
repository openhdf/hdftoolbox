#!/bin/sh

# starting cardserver and softcam
if [ -e /etc/init.d/cardserver ] ; then
	echo "starting cardserver"
	/etc/init.d/cardserver restart
	sleep 1
fi

if [ -e /etc/init.d/softcam ] ; then
	echo "starting softcam"
	/etc/init.d/softcam restart
	sleep 1
fi
