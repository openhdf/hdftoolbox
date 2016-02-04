#!/bin/sh

echo -e "\nfix opkg package problems"
sleep 1
find /var/lib/opkg/status -type f -exec sed -i 's/Version: 1.6.0-r0/Version: 1.6.1-r0/' {} \;
find /var/lib/opkg/status -type f -exec sed -i 's/Conflicts: /#Conflicts:/' {} \;
find /var/lib/opkg/status -type f -exec sed -i 's/Version: 1.6.1-r0/Version: 1.7.1-r0/' {} \;
find /var/lib/opkg/status -type f -exec sed -i 's/Version: 1.7+git14825+3674742/Version: 1.7.1-r0/' {} \;
echo -e "\nopkg update"
opkg update
opkg --force-depends --force-reinstall install libgstvideo-1.0-0 libgstriff-1.0-0 libgstcodecparsers-1.0-0 libgstadaptivedemux-1.0-0 gstreamer1.0 libgsttag-1.0-0 libgstsdp-1.0-0 libgsturidownloader-1.0-0 libgstrtsp-1.0-0 gstreamer1.0-plugins-good gstreamer1.0-plugin-dvbmediasink gstreamer1.0-plugins-good
opkg flag ok libgstvideo-1.0-0 libgstriff-1.0-0 libgstcodecparsers-1.0-0 libgstadaptivedemux-1.0-0 gstreamer1.0 libgsttag-1.0-0 libgstsdp-1.0-0 libgsturidownloader-1.0-0 libgstrtsp-1.0-0 gstreamer1.0-plugins-good gstreamer1.0-plugin-dvbmediasink gstreamer1.0-plugins-good
echo -e "done\nopkg upgrade"
opkg upgrade
echo -e "done\n\nand now we must restart enigma!"
sleep 2
killall enigma2
echo

exit 0   
