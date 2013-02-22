#!/bin/sh
##Teamimage Script by HDFreaks.cc

echo "This script create a teamimage ... almost but not complete"
echo
echo "please wait".
echo
echo "remove old plugins"
opkg remove enigma2-plugin-extensions-remotestreamconvert enigma2-plugin-systemplugins-extnumberzap
opkg install kernel-module-nfs-layout-nfsv41-files
echo
echo "install system plugins"
opkg install enigma2-plugin-extensions-bootvideo-hdf enigma2-plugin-extensions-zaphistorybrowser.mod enigma2-plugin-extensions-virtualzap.mod
opkg install enigma2-plugin-extensions-2ib enigma2-plugin-extensions-et-portal enigma2-plugin-extensions-openairplaymod
opkg install enigma2-plugin-extensions-seekbarmod enigma2-plugin-extensions-webinterface-old-package enigma2-plugin-extensions-menusort
opkg install enigma2-plugin-extensions-jobmanager enigma2-plugin-systemplugins-satelliteequipmentcontrol
echo
echo "install addons"
opkg install enigma2-plugin-extensions-Burnseries enigma2-plugin-extensions-webradiofs enigma2-plugin-extensions-skyanytime
opkg install enigma2-plugin-extensions-mediaportal enigma2-plugin-extensions-tvkino enigma2-plugin-extensions-moviecut
opkg install enigma2-plugin-extensions-songsto enigma2-plugin-extensions-putpattv enigma2-plugin-extensions-netzkino
opkg install enigma2-plugin-extensions-myentertainment enigma2-plugin-extensions-movie2kserien enigma2-plugin-extensions-enhancedpowersave
opkg install enigma2-plugin-extensions-movie2kfilme enigma2-plugin-extensions-kinokiste enigma2-plugin-extensions-istream
opkg install enigma2-plugin-extensions-dokumonster enigma2-plugin-extensions-cinestreamer enigma2-plugin-extensions-remotechannelstreamimport
opkg install enigma2-plugin-extensions-epgrefresh_mod enigma2-plugin-extensions-yampmusicplayer enigma2-plugin-extensions-socketmmi
opkg install enigma2-plugin-systemplugins-recordinfobar enigma2-plugin-extensions-icefilms enigma2-plugin-extensions-cubic_streamer
opkg install enigma2-plugin-extensions-cooltvguide enigma2-plugin-extensions-pipservicerelation.mod enigma2-plugin-extensions-dreamexplorer
opkg install enigma2-plugin-extensions-infobartunerstate-mod enigma2-plugin-extensions-flashexpander
echo
echo "done ... but not complete"
echo "please reboot your box now"
echo