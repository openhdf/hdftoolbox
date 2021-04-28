#!/bin/sh

echo -e "\nfind <log code= in /etc/enigma2/timers.xml and remove this"
sleep 1
echo -e "\nand now we must restart enigma!\n"
init 4
sleep 1
sed -i '/log code\=/d' /etc/enigma2/timers.xml
init 3

exit 0
