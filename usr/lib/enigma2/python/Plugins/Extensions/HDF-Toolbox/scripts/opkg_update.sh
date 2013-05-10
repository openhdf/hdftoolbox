#!/bin/sh

cd /tmp
echo "Download and install update"
echo
echo "starting okgp update & upgrade"
opkg update  > /dev/null 2>&1
opkg upgrade
echo
echo "Update Done ... Please reboot your Box now!"

exit 0 
