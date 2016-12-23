#!/bin/sh

#
# openHDF: backup / restore STB kernel drivers
# tested on: formuler1, zgemmahs, mutant1500, et9x00
#

# Copyright 2015, 2016 nomjasV D2;>@?]ADo8>2:=]4@>, Austria
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

cfghdftoolspath=/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/menu/tools.cfg

IMGBUILD=$(grep ^getImageBuild /tmp/.ImageVersion | awk '{print $3}')
BOXDRVKERNELVERS=$(opkg list-installed | grep dvb-modules | awk '{print $3}' | tr -d "\015")
RESTOREKERNELCFGFILE=/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/menu/restorestbkerneldrv.cfg
KERNELBACKUPSDIR=/hdd/backup_kerneldrivers_$(uname -n)
FILENAME=kerneldrivers-$IMGBUILD-$BOXDRVKERNELVERS.tar.gz

ez=$(uname -n | cut -c 1-1 | tr [a-z] [A-Z])
l=$(uname -n | wc -L)
r=$(uname -n | cut -c 2-$l)
BOXINFO=$(echo ${ez}${r})

# backup
	[ -d $KERNELBACKUPSDIR ] || mkdir $KERNELBACKUPSDIR
	   touch /lib/modules/$(uname -r)/extra/installed-$IMGBUILD-$BOXDRVKERNELVERS
	  find /lib/modules/$(uname -r)/extra -type f >$$
	opkg files $(opkg list-installed | grep dvb-modules) | grep conf >>$$
	 echo -e "create $KERNELBACKUPSDIR/$FILENAME\n"
	   tar -czvf $KERNELBACKUPSDIR/$FILENAME -T $$
	rm -f $$
	chmod 644 $KERNELBACKUPSDIR/$FILENAME
	echo "done..."

#prepare restore cfg
echo "S:menu/restorestbkerneldrv:Restore $BOXINFO Kernel Drivers (reboot required):touch /tmp/hdf.txt" >$RESTOREKERNELCFGFILE

	( cd $KERNELBACKUPSDIR
	stbko=$(ls *$(uname -r)* | sort | sed "s/\.tar.gz//")
		for drv in $stbko;do
	echo "C:menu/restorestbkerneldrv:$drv:tar -xzvf $KERNELBACKUPSDIR/$drv.tar.gz -C /;echo:" >>$RESTOREKERNELCFGFILE
  done )

cat << RESTORECFG >>$RESTOREKERNELCFGFILE
M:menu/$BOXINFO:Return to $BOXINFO Tools menu
M:main:Return to Main Menu
RESTORECFG

# tools.cfg - fixed STB name
  if ! grep "Backup $BOXINFO kernel drivers" $cfghdftoolspath >/dev/null ;then
 echo -e "\n### Prepare tools.cfg, move STB to $BOXINFO ###\n"
sed -i "s/Backup STB/Backup $BOXINFO/g;s/Restore STB/Restore $BOXINFO/g" $cfghdftoolspath
fi

 rm -f /lib/modules/$(uname -r)/extra/installed-$IMGBUILD-$BOXDRVKERNELVERS

exit 0
