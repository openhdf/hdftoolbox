#!/bin/sh
echo "Checking free space..."
FREE=`df -Pk /usr | tr -s ' ' | cut -d' ' -f4 | tail -n1`
if [[ $FREE -lt 12000 ]]; then
	echo "not enough free space to install all drivers!"
else
	echo "Please wait ... install all WLan drivers"
	opkg install firmware-rtl8192cu firmware-rtl8712u kernel-module-rtl8192cu kernel-module-rtl8187 kernel-module-carl9170 packagegroup-base-wifi
	opkg install rtl8192cu kernel-module-ath9k-htc kernel-module-ath9k-common kernel-module-ath9k-hw kernel-module-atbm8830
	opkg install kernel-module-ath9k kernel-module-carl9170 kernel-module-zd1211rw kernel-module-ath kernel-module-at76c50x-usb
	opkg install kernel-module-rt2500usb kernel-module-rt2800lib kernel-module-rt2800usb kernel-module-rt2x00usb kernel-module-rt73usb kernel-module-rt2x00lib
	opkg install rt5572 enigma2-plugin-drivers-network-usb-rt5572 kernel-module-mwifiex-usb kernel-module-rtlwifi oe-alliance-wifi
	opkg install enigma2-plugin-drivers-network-usb-rtl8192cu enigma2-plugin-drivers-network-usb-rtl8192cu-rev2 enigma2-plugin-drivers-network-usb-asix
	opkg install enigma2-plugin-drivers-network-usb-ax88179-178a enigma2-plugin-drivers-network-usb-mt7601u enigma2-plugin-drivers-network-usb-mt7610u
	opkg install enigma2-plugin-drivers-network-usb-r8723a enigma2-plugin-drivers-network-usb-rt3070 enigma2-plugin-drivers-network-usb-rt3573
	opkg install enigma2-plugin-drivers-network-usb-rt8723bs enigma2-plugin-drivers-network-usb-rtl8192ce enigma2-plugin-drivers-network-usb-rtl8192eu
	opkg install enigma2-plugin-drivers-network-usb-rtl8812au enigma2-plugin-drivers-network-usb-smsc75xx
	echo
	echo "Now reboot your box to load the drivers and modules"
	echo
fi

exit 0
