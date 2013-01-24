#!/bin/sh
##Teamimage Script by HDFreaks.cc

echo "This script create a teamimage ... almost but not complete"
echo
echo "please wait".
echo

opkg install enigma2-plugin-extensions-Burnseries
opkg install enigma2-plugin-extensions-bootvideo-hdf enigma2-plugin-extensions-zaphistorybrowser.mod enigma2-plugin-extensions-virtualzap.mod
opkg install enigma2-plugin-extensions-2ib enigma2-plugin-extensions-et-portal enigma2-plugin-extensions-webradiofs
opkg install enigma2-plugin-extensions-openairplaymod enigma2-plugin-extensions-mediaportal enigma2-plugin-extensions-tvkino
opkg install enigma2-plugin-extensions-songsto enigma2-plugin-extensions-putpattv enigma2-plugin-extensions-netzkino
opkg install enigma2-plugin-extensions-myentertainment enigma2-plugin-extensions-movie2kserien
opkg install enigma2-plugin-extensions-movie2kfilme enigma2-plugin-extensions-kinokiste enigma2-plugin-extensions-istream
opkg install enigma2-plugin-extensions-dokumonster enigma2-plugin-extensions-cinestreamer enigma2-plugin-extensions-remotestreamconvert
opkg install enigma2-plugin-extensions-seekbarmod enigma2-plugin-extensions-webinterface-old-package
opkg install enigma2-plugin-extensions-epgrefresh_mod enigma2-plugin-extensions-yampmusicplayer
opkg install enigma2-plugin-systemplugins-recordinfobar enigma2-plugin-extensions-icefilms enigma2-plugin-extensions-cubic_streamer
opkg install enigma2-plugin-extensions-jobmanager enigma2-plugin-systemplugins-extnumberzap enigma2-plugin-systemplugins-crossepg
opkg install enigma2-plugin-extensions-menusort enigma2-plugin-extensions-cooltvguide enigma2-plugin-extensions-pipservicerelation.mod

echo
echo "done ... but not complete"
echo "please reboot your box now"
echo