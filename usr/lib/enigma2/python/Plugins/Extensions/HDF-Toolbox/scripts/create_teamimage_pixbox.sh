#!/bin/sh
##Teamimage Script by HDFreaks.cc
##pixbox - 28.03.2017

echo "Ein Teamimage pixbox Edition wird erstellt..."
echo
echo "bitte warten".
echo
opkg update > /dev/null 2>&1
ln -s /usr/share/enigma2/spinner /usr/share/enigma2/skin_default/spinner
echo
echo "remove all picon"
rm -f /usr/share/enigma2/picon/*.* > /dev/null 2>&1
echo
echo "remove preinstalled unwanted plugins"
opkg remove --force-depends enigma2-plugin-settings-defaultsat
opkg remove --force-depends enigma2-plugin-systemplugins-autobouquetsmaker
opkg remove --force-depends enigma2-plugin-systemplugins-cablescan
opkg remove --force-depends enigma2-plugin-systemplugins-blindscan
opkg remove --force-depends enigma2-plugin-extensions-audiosync
opkg remove --force-depends enigma2-plugin-extensions-volume-adjust
opkg remove --force-depends enigma2-plugin-extensions-remotestreamconvert
echo
echo "install depends"
opkg install livestreamersrv \
python-youtube-dl \
python-mutagen \
python-textutils \
curl \
udpxy
echo
echo "install system plugins" 
opkg install enigma2-plugin-systemplugins-satelliteequipmentcontrol \
enigma2-plugin-systemplugins-autoswitch3d \
enigma2-plugin-systemplugins-extnumberzap \
enigma2-plugin-systemplugins-automaticvolumeadjustment
echo
echo "install extensions"
opkg install enigma2-plugin-extensions-customsubservices \
enigma2-plugin-extensions-infobartunerstate \
enigma2-plugin-extensions-albatros \
enigma2-plugin-extensions-mediainfo \
enigma2-plugin-extensions-mediaportal \
enigma2-plugin-extensions-piconmanager \
enigma2-plugin-extensions-remotechannelstreamimport \
enigma2-plugin-extensions-moviecut \
enigma2-plugin-extensions-webradiofs \
enigma2-plugin-extensions-werbezapper \
enigma2-plugin-extensions-epgimport \
enigma2-plugin-extensions-zaphistorybrowser
echo
echo "install Astra 19.2 settings"
opkg install enigma2-plugin-settings-astra-pixbox
echo
echo "check box now"
line=$(grep -e 'vusolose\|vuduo2\|vusolo2' /etc/enigma2/boxinformations)
if [ -n $? ]; then
	echo $line
	opkg install enigma2-plugin-systemplugins-animationsetup > /dev/null 2>&1
else
    echo "Vu SoloSE/Duo2/Solo2 not found"
fi
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
