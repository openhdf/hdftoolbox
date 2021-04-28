#!/bin/sh

echo
echo "Please wait ... remove all WLan Drivers"
opkg remove --force-depends firmware-rtl8192cu firmware-rtl8712u kernel-module-rtl8192cu kernel-module-rtl8187 kernel-module-ath3k kernel-module-carl9170 kernel-module-rtl8150
opkg remove --force-depends rtl8192cu kernel-module-ath9k-htc kernel-module-ath9k-common kernel-module-ath9k-hw kernel-module-atbm8830 kernel-module-catc kernel-module-rndis-wlan
opkg remove --force-depends kernel-module-ath9k kernel-module-carl9170 kernel-module-zd1211rw kernel-module-ath kernel-module-at76c50x-usb kernel-module-dvb-usb-rtl2832
opkg remove --force-depends kernel-module-rt2500usb kernel-module-rt2800lib kernel-module-rt2800usb kernel-module-rt2x00usb kernel-module-rt73usb kernel-module-rt2x00lib
opkg remove --force-depends rt5572 enigma2-plugin-drivers-network-usb-rt5572 enigma2-plugin-drivers-network-usb-rtl8192cu

echo
echo "Now reboot your box to unload the drivers and modules"
echo
exit 0
