#!/bin/sh

target=/usr/share/

echo "speedtest use = $target"
echo

echo "speedtest $target ~ 1MB ... please wait"
time dd if=/dev/zero of=$target/blanks2 bs=1024k count=1
rm $target/blanks2
echo

echo "speedtest $target ~ 5MB ... please wait"
dd if=/dev/zero of=$target/blanks2 bs=1024k count=5
rm $target/blanks2
echo

echo "speedtest $target ~ 10MB ... please wait"
time dd if=/dev/zero of=$target/blanks2 bs=1024k count=10
rm $target/blanks2
echo

exit 0
