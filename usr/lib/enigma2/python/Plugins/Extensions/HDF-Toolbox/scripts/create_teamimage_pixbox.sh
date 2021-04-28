#!/bin/sh
##Teamimage Script by HDFreaks.cc
##pixbox - 19.07.2018

echo "Ein Teamimage pixbox Edition wird erstellt..."
echo
echo "bitte warten".
echo
opkg update > /dev/null 2>&1
ln -s /usr/share/enigma2/spinner /usr/share/enigma2/skin_default/spinner
echo
echo "remove all picon"
rm -f /usr/share/enigma2/picon/*.* > /dev/null 2>&1
echo "config.usage.hdfpicon=false" >> /etc/enigma2/settings
echo
echo "remove preinstalled unwanted plugins"
opkg remove --force-depends enigma2-plugin-settings-defaultsat
opkg remove --force-depends enigma2-plugin-systemplugins-autobouquetsmaker
opkg remove --force-depends enigma2-plugin-systemplugins-fastscan
opkg remove --force-depends enigma2-plugin-systemplugins-cablescan
opkg remove --force-depends enigma2-plugin-systemplugins-blindscan
opkg remove --force-depends enigma2-plugin-extensions-audiosync
opkg remove --force-depends enigma2-plugin-extensions-volume-adjust
opkg remove --force-depends enigma2-plugin-extensions-remotestreamconvert
opkg remove --force-depends enigma2-plugin-extensions-cdinfo
opkg remove --force-depends enigma2-plugin-extensions-dvdburn
echo
echo "install depends"
opkg install python-youtube-dl \
python-mutagen \
python-textutils
echo
echo "install system plugins"
opkg install enigma2-plugin-systemplugins-automaticvolumeadjustment
echo
echo "install extensions"
opkg install enigma2-plugin-extensions-customsubservices \
enigma2-plugin-extensions-streamlinkserver \
enigma2-plugin-extensions-mediainfo \
enigma2-plugin-extensions-mediaportal \
enigma2-plugin-extensions-piconsupdater \
enigma2-plugin-extensions-iptvplayer \
enigma2-plugin-extensions-moviecut \
enigma2-plugin-extensions-webradiofs \
enigma2-plugin-extensions-werbezapper \
enigma2-plugin-extensions-epgimport \
enigma2-plugin-extensions-mpgz
echo
echo "install Astra 19.2 settings"
opkg install enigma2-plugin-settings-astra-pixbox
echo
echo "Installation erfolgreich abgeschlossen!"
echo
echo "Nun bitte neu booten, zuvor aber Hinweise lesen!"
echo
echo "Hinweis: nach dem Reboot Favoriten > Sender neu waehlen"
echo
echo "Das Teamimage pixbox Edition ist damit fertig"
echo "Viel Spass damit wuenscht pixbox"
echo
echo "Automatischer Enigma2 Neustart in 5 Sekunden!"
echo
sleep 5
killall -9 enigma2
