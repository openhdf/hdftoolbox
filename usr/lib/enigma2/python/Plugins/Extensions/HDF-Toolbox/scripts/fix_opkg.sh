#!/bin/sh

echo
echo "fix opkg package problems"
sleep 1
find /var/lib/opkg/status -type f -exec sed -i 's/Version: 1.6.0-r0/Version: 1.6.1-r0/' {} \;
echo
echo "opkg update"
opkg update
echo "done"
echo "opkg upgrade"
opkg upgrade
echo "done"
echo
echo
echo "and now we must restart enigma!"
sleep 2
killall enigma2
echo

exit 0   
