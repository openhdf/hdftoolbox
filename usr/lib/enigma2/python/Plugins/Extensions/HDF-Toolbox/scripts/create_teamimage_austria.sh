#!/bin/sh
##Teamimage Script by HDFreaks.cc
##googgi - 20.01.2015

echo "Ein Teamimage Austria Edition wird erstellt..."
echo
echo "bitte warten".
echo
opkg update > /dev/null 2>&1
ln -s /usr/share/enigma2/spinner /usr/share/enigma2/skin_default/spinner
echo "remove preinstalled unwanted plugins"
opkg remove enigma2-plugin-extensions-enhancedmoviecenter \
opkg remove enigma2-plugin-extensions-remotestreamconverter \
opkg remove enigma2-plugin-extensions-remotechannelstreamimport
echo
echo "install system plugins"
opkg install sqlite3 \
enigma2-plugin-systemplugins-extnumberzap \
enigma2-plugin-systemplugins-satelliteequipmentcontrol \
enigma2-plugin-systemplugins-weathercomponenthandler
echo
echo "install extensions"
opkg install enigma2-plugin-extensions-audiosync \
enigma2-plugin-extensions-cooltvguide \
enigma2-plugin-extensions-customsubservices \
enigma2-plugin-extensions-dreamexplorer \
enigma2-plugin-extensions-et-portal \
enigma2-plugin-extensions-imdb \
enigma2-plugin-extensions-infobartunerstate \
enigma2-plugin-extensions-mediainfo \
enigma2-plugin-extensions-mediaportal \
enigma2-plugin-extensions-piconmanager \
enigma2-plugin-extensions-picturecenterfs \
enigma2-plugin-extensions-remotechannelstreamconverter \
enigma2-plugin-extensions-tvspielfilm \
enigma2-plugin-extensions-webradiofs  \
enigma2-plugin-extensions-werbezapper \
enigma2-plugin-extensions-wikipedia \
enigma2-plugin-extensions-xbmcwetter \
enigma2-plugin-extensions-zaphistorybrowser
echo
echo "install austria settings"
opkg install enigma2-plugin-settings-googgi 
echo
echo "install nblack51-skin"
opkg install enigma2-plugin-skins-nblack51-openhdf-mod 
echo
echo "Installation erfolgreich abgeschlossen!"
echo
echo "Nun bitte neu booten, zuvor aber Hinweise lesen!"
echo
echo "Hinweis 1: nach dem Reboot Favorit > Sender neu waehlen"
echo
echo "Hinweis 2: HDF-Toolbox > Skin Selector > Skin wechseln auf: nblack51.openhdf.mod"
echo
echo "Das Teamimage Austria ist damit fertig"
echo "Viel Spass damit wuenscht Googgi"
echo
