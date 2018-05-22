echo 'please wait ... ready after complete restart'
sleep 1
cp /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/scripts/bootfiles/bootmisc.sh /etc/init.d/
cp /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/scripts/bootfiles/enigma2_pre_start.sh /usr/bin/
chmod -R 755 /etc/init.d/bootmisc.sh
chmod -R 755 /usr/bin/enigma2_pre_start.sh
sleep 1
echo
echo 'reboot now'
reboot
