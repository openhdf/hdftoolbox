#!/bin/sh

echo -e "\nfix opkg package problems"
sleep 1
sed -i 's/Version: 1.6.0-r0/Version: 1.6.1-r0/' /var/lib/opkg/status
sed -i 's/Conflicts: /d/' /var/lib/opkg/status
echo -e "\nopkg update"
opkg update
echo -e "done\nopkg upgrade"
opkg upgrade
echo -e "done\n\nand now we must restart enigma!"
sleep 2
killall enigma2
echo

exit 0   
