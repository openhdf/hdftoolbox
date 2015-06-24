#!/bin/sh

echo "remove all picon from usb/hdd"
rm -f /media/usb/picon/*.* > /dev/null 2>&1
rmdir /media/usb/picon > /dev/null 2>&1
rm -f /media/hdd/picon/*.* > /dev/null 2>&1
rmdir /media/hdd/picon > /dev/null 2>&1
echo
echo "Picon removed"
echo

exit 0 
