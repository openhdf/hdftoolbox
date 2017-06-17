#!/bin/sh

echo
echo "####################### running HDFreaks autostart scripts ####################### "
echo

##set temp output file
cat /proc/stb/info/boxtype > /tmp/hdf.txt
cat /proc/version >> /tmp/hdf.txt
echo "" >> /tmp/hdf.txt
less /etc/version >> /tmp/hdf.txt
echo "" >> /tmp/hdf.txt
cat /proc/stb/info/chipset >> /tmp/hdf.txt
echo "" >> /tmp/hdf.txt
cat /proc/cpuinfo >> /tmp/hdf.txt

#check image version and write to issue.net
imageversion=`awk '/getImageVersion/ {print $3}' /tmp/.ImageVersion`
imagebuild=`grep ^version /etc/image-version | cut -f2 -d=`
if ! grep "$imageversion build: $imagebuild" /etc/issue.net >/dev/null ;then
	sed -i "s|^~ HDFreaks Image.*|~ HDFreaks Image V$imageversion build: $imagebuild ~|" /etc/issue.net
fi

#check spinner symlink
ln -fs /usr/share/enigma2/spinner/ /usr/share/enigma2/skin_default/.

#check ld-linux symlink
python /usr/lib/enigma2/python/BoxBrandingTest.pyo | sed 's/<$//g;s/ /_/g' > /tmp/boxbranding.cfg
if grep -Eqs 'cortexa15hf-neon-vfpv4' cat /tmp/boxbranding.cfg; then
	ln -fs /lib/ld-linux-armhf.so.3 /lib/ld-linux.so.3
fi

##create iptv symlinks to /usr/scripts/ for cronjobs
echo "check scripts and create symlinks"
[ -d /usr/scripts ] || mkdir /usr/scripts
rm -f /usr/scripts/IPTV_*
