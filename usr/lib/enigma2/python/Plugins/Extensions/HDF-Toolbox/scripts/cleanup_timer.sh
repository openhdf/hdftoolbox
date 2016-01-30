#!/bin/sh

echo -e "\nfind <log code= in /etc/enigma2/timers.xml and remove this"
sleep 5
sed -i '/<log code="/d' /etc/enigma2/timers.xml
echo -e "\nand now we must restart enigma!"
sleep 4
killall enigma2
sleep 2
echo

exit 0   
