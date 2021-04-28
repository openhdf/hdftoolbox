#!/bin/sh

echo "remove all picon from usb/hdd"
rm -rf /media/usb/picon > /dev/null 2>&1
rm -rf /media/hdd/picon > /dev/null 2>&1
echo -e "\nPicon removed\n"

exit 0
