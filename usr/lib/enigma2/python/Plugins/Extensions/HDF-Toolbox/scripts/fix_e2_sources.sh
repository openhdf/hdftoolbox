echo 'please wait ... ready after complete restart'
sleep 2
init 4
opkg update
opkg install enigma2-src --force-reinstall
init 3
sleep 40
init 4
opkg remove enigma2-src
sleep 5
reboot
