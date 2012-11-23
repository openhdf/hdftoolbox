#!/bin/sh

echo
echo "delete .gstreamer-0.10/registry.mipsel.bin & reboot stb"
sleep 3
rm -f /home/root/.gstreamer-0.10/registry.mipsel.bin
sleep 2
echo
echo "registry.mipsel.bin delete ... now reboot"
echo
sleep 3
reboot

exit 0   
