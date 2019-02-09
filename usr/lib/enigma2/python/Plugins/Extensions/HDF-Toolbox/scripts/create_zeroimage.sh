#!/bin/sh
##Zeroimage Script by HDFreaks.cc
##02.02.2019

echo "Deinstallation von nicht relevanten Plugins, Samba und WLAN"
echo
echo "bitte warten".
echo
echo "remove all picon"
rm -f /usr/share/enigma2/picon/*.* > /dev/null 2>&1
echo
echo "remove preinstalled unwanted plugins"
opkg remove defaultsat
opkg remove --force-depends enigma2-plugin-systemplugins-autobouquetsmaker
opkg remove --force-depends enigma2-plugin-systemplugins-cablescan
opkg remove --force-depends enigma2-plugin-systemplugins-blindscan
opkg remove --force-depends enigma2-plugin-extensions-audiosync
opkg remove --force-depends enigma2-plugin-extensions-volume-adjust
opkg remove --force-depends enigma2-plugin-extensions-remotestreamconvert
opkg remove --force-depends enigma2-plugin-extensions-enhancedmoviecenter
opkg remove --force-depends enigma2-plugin-extensions-hbbtv
opkg remove --force-depends enigma2-plugin-extensions-openwebif
opkg remove --force-depends vuplus-opera-browser-util
opkg remove --force-depends vuplus-opera-dumpait
opkg remove --force-depends samba-base samba packagegroup-base-smbfs-client packagegroup-base-smbfs-server packagegroup-base-smbfs-utils packagegroup-base-smbfs
opkg remove --force-depends firmware-rtl8192cu firmware-rtl8712u kernel-module-rtl8192cu kernel-module-rtl8187 kernel-module-ath3k kernel-module-carl9170 kernel-module-rtl8150
opkg remove --force-depends rtl8192cu kernel-module-ath9k-htc kernel-module-ath9k-common kernel-module-ath9k-hw kernel-module-atbm8830 kernel-module-catc kernel-module-rndis-wlan
opkg remove --force-depends kernel-module-ath9k kernel-module-carl9170 kernel-module-zd1211rw kernel-module-ath kernel-module-at76c50x-usb kernel-module-dvb-usb-rtl2832
opkg remove --force-depends kernel-module-rt2500usb kernel-module-rt2800lib kernel-module-rt2800usb kernel-module-rt2x00usb kernel-module-rt73usb kernel-module-rt2x00lib
opkg remove --force-depends rt5572 enigma2-plugin-drivers-network-usb-rt5572 enigma2-plugin-drivers-network-usb-rtl8192cu
echo "remove /usr/lib/locale/"
opkg remove minilocale --force-depends
cp -rf /usr/lib/locale/ /tmp/
rm -rf /usr/lib/locale/*
echo
echo "Deinstallation erfolgreich abgeschlossen!"
echo
echo "Nun bitte neu booten!"
echo
