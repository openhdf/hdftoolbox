#!/bin/sh

echo
echo "find <log code= in /etc/enigma2/timers.xml and remove this"
sleep 5
find /etc/enigma2/timers.xml -type f -exec sed -i '/<log code="/d' {} \;
echo
echo "and now we must restart enigma!"
sleep 4
killall enigma2
sleep 2
echo

exit 0   
