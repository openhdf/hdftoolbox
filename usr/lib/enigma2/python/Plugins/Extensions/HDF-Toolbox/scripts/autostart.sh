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

##create iptv symlinks to /usr/scripts/ for cronjobs
echo "check scripts and create symlinks"
[ -d /usr/scripts ] || mkdir /usr/scripts
rm -f /usr/scripts/IPTV_*
#ln -fs /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/scripts/IPTV_* /usr/scripts/.
