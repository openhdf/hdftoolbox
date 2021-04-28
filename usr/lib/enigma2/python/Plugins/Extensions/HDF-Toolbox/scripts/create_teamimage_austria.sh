#!/bin/sh
##Teamimage Script by HDFreaks.cc
##googgi - 28.12.2018

echo "Ein Teamimage Austria Edition wird erstellt..."
echo
echo "(c) by googgi"
echo
echo "bitte warten".
echo
opkg update > /dev/null 2>&1
echo
echo "install system plugins"
opkg install sqlite3 \
enigma2-plugin-systemplugins-extnumberzap
echo
echo "install extensions"
opkg install enigma2-plugin-extensions-cooltvguide \
enigma2-plugin-extensions-infobartunerstate \
enigma2-plugin-extensions-mediainfo \
enigma2-plugin-extensions-mediaportal \
enigma2-plugin-extensions-mpgz \
enigma2-plugin-extensions-piconmanager \
enigma2-plugin-extensions-webradiofs  \
enigma2-plugin-extensions-werbezapper \
enigma2-plugin-extensions-xbmcwetter \
enigma2-plugin-extensions-zaphistorybrowser
echo
echo "install austria settings"
opkg install enigma2-plugin-settings-austria-19.2-13.0-by-googgi
echo
echo "install nblack51-skin"
opkg install enigma2-plugin-skins-nblack51-openhdf-mod
echo
echo "Installation erfolgreich abgeschlossen!"
echo
echo "Hinweis 1: HDF-Toolbox > Skin Selector > Skin wechseln auf: nblack51.openhdf.mod"
echo
echo "Hinweis 2: nach dem Reboot die Taste 1 drücken, um in den Favorit AUSTRIA zu kommen"
echo
echo "Das Teamimage Austria ist damit fertig"
echo "Viel Spass damit wuenscht Googgi"
echo
