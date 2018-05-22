#!/bin/sh
##Teamimage Script by HDFreaks.cc

echo "This script create a teamimage ... almost but not complete"
echo
echo "please wait".
echo
opkg update > /dev/null 2>&1
ln -s /usr/share/enigma2/spinner /usr/share/enigma2/skin_default/spinner
echo "remove old plugins"
opkg remove enigma2-plugin-extensions-remotestreamconverter
opkg remove enigma2-plugin-extensions-remotechannelstreamimport
echo
echo "install system plugins"
opkg install sqlite3 \
enigma2-plugin-systemplugins-weathercomponenthandler \
enigma2-plugin-systemplugins-extnumberzap \
enigma2-plugin-systemplugins-satelliteequipmentcontrol \
enigma2-plugin-systemplugins-recordinfobar \
enigma2-plugin-systemplugins-aspectratioswitch
echo
echo "install extensions"
opkg install enigma2-plugin-extensions-webradiofs \
enigma2-plugin-extensions-serienrecorder \
enigma2-plugin-extensions-et-portal \
enigma2-plugin-extensions-zaphistorybrowser \
enigma2-plugin-extensions-virtualzap.mod \
enigma2-plugin-extensions-cooltvguide \
enigma2-plugin-extensions-picturecenterfs \
enigma2-plugin-extensions-menusort \
enigma2-plugin-extensions-jobmanager \
enigma2-plugin-extensions-mediainfo \
enigma2-plugin-extensions-enhancedpowersave \
enigma2-plugin-extensions-werbezapper \
enigma2-plugin-extensions-epgimport \
enigma2-plugin-extensions-tvcharts \
enigma2-plugin-extensions-dreamexplorer \
enigma2-plugin-extensions-remotechannelstreamconverter \
enigma2-plugin-extensions-epgrefresh \
enigma2-plugin-extensions-yampmusicplayerfullhd \
enigma2-plugin-extensions-xbmcwetter \
enigma2-plugin-extensions-customsubservices \
enigma2-plugin-extensions-audiosync \
enigma2-plugin-extensions-piconsupdater \
enigma2-plugin-extensions-iptvplayer \
iptv-player-xxx \
enigma2-plugin-extensions-moviecut \
enigma2-plugin-extensions-reconstructapsc \
enigma2-plugin-extensions-tvspielfilm \
enigma2-plugin-extensions-youtube \
enigma2-plugin-extensions-xmltvimport \
enigma2-plugin-extensions-mediaportal \
enigma2-plugin-extensions-mpgz
echo

echo "check box now"
line=$(grep ixuss /etc/enigma2/boxinformations)
if [ -n $? ]; then
	echo $line
	opkg remove enigma2-plugin-systemplugins-pipservicerelation
else
    echo "Ixuss Box found"
fi

echo
echo "And what now? I think a reboot would be great."
echo
