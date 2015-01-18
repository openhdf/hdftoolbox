#!/bin/sh
##Teamimage Script by HDFreaks.cc

echo "Ein Teamimage Austria Edition wird erstellt..."
echo
echo "bitte warten".
echo
opkg update > /dev/null 2>&1
ln -s /usr/share/enigma2/spinner /usr/share/enigma2/skin_default/spinner
echo "remove old plugins"
opkg remove enigma2-plugin-extensions-remotestreamconvert
opkg remove enigma2-plugin-extensions-enhancedmoviecenter
echo
echo "install system plugins"
opkg install enigma2-plugin-extensions-bootvideo \
sqlite3 \
enigma2-plugin-systemplugins-weathercomponenthandler \
enigma2-plugin-systemplugins-extnumberzap \
enigma2-plugin-systemplugins-satelliteequipmentcontrol \
echo
echo "install extensions"
opkg install enigma2-plugin-extensions-webradiofs \
enigma2-plugin-extensions-et-portal \
enigma2-plugin-extensions-zaphistorybrowser \
enigma2-plugin-extensions-cooltvguide \
enigma2-plugin-extensions-mediainfo \
enigma2-plugin-extensions-mediaportal \
enigma2-plugin-extensions-infobartunerstate \
enigma2-plugin-extensions-imdb \
enigma2-plugin-extensions-dreamexplorer \
enigma2-plugin-extensions-remotechannelstreamimport \
enigma2-plugin-extensions-customsubservices \
enigma2-plugin-extensions-audiosync \
enigma2-plugin-extensions-piconmanager \
enigma2-plugin-extensions-werbezapper \
enigma2-plugin-extensions-wikipedia \
enigma2-plugin-extensions-foreca \
enigma2-plugin-extensions-tvspielfilm
echo
echo "install extensions"
opkg install enigma2-plugin-settings-googgi \
echo
echo "install skin"
opkg install enigma2-plugin-skins-nblack51-openhdf-mod \
echo
echo "check box now"
echo