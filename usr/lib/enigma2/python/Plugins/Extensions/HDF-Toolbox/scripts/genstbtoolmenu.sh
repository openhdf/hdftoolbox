#!/bin/sh

# Copyright 2015, 2016 nomjasV aka octagoN D2;>@?]ADo8>2:=]4@>, Austria
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
## 16.10.16 - add to all cfg M:menu/${BOXNAME}:Return to ${BOXNAME} Tools menu ##
## 22.10.16 - add /usr/scripts/boxtoolmenu.conf for Image ${BOXNAME} Tools, User can define the PATH itself ##
## 22.10.16 - fixed tr ##
#

MEDIAPATH=/usr/scripts

#BOXNAME=$(cat /proc/stb/info/boxtype)
ez=$(uname -n | cut -c 1-1 | tr '[a-z]' '[A-Z]')
l=$(uname -n | wc -L)
r=$(uname -n | cut -c 2-$l)

BOXNAME=$(echo ${ez}${r})

hdftoolpath=/usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox
if [ -r $MEDIAPATH/boxtoolmenu.conf ];then
	CREATEDIRECTORY=$(grep ^BOXDIRTOOLPATH $MEDIAPATH/boxtoolmenu.conf | cut -f2 -d=)
else
	CREATEDIRECTORY=${MEDIAPATH}/${BOXNAME}-UserTools
	echo -e "#Image ${BOXNAME} Tools PATH - define the PATH itself\n\nBOXDIRTOOLPATH=${MEDIAPATH}/${BOXNAME}-UserTools" >$MEDIAPATH/boxtoolmenu.conf
fi

# User Tools directory on /usr/scripts
if [ ! -d ${CREATEDIRECTORY} ];then
echo -e "\n### Create ${BOXNAME} Tools directory ###\n${CREATEDIRECTORY}\n"
mkdir -p ${CREATEDIRECTORY}/${BOXNAME}_menu
mkdir ${CREATEDIRECTORY}/${BOXNAME}_scripts

echo -e "### Create ${BOXNAME} main menu ###\n${CREATEDIRECTORY}/${BOXNAME}.cfg\n"
cat << BOXNAMECFG >${CREATEDIRECTORY}/${BOXNAME}.cfg
S:${BOXNAME}_menu/${BOXNAME}:Image ${BOXNAME} Tools:touch /tmp/hdf.txt
M:${BOXNAME}_menu/first:my first menu
M:main:Return to Main Menu
BOXNAMECFG

echo -e "### Create first.cfg, my_first.sh for testing ###\n${CREATEDIRECTORY}/${BOXNAME}_menu/first.cfg\n${CREATEDIRECTORY}/${BOXNAME}_scripts/my_first.sh"
cat << MYFIRSTCFG >${CREATEDIRECTORY}/${BOXNAME}_menu/first.cfg
S:${BOXNAME}_menu/first:My First Menu:touch /tmp/hdf.txt
C:${BOXNAME}_menu/first:Run my first script:${BOXNAME}_scripts/my_first.sh
M:menu/${BOXNAME}:Return to ${BOXNAME} Tools menu
M:main:Return to Main Menu
MYFIRSTCFG

echo '#!/bin/sh' >${CREATEDIRECTORY}/${BOXNAME}_scripts/my_first.sh
echo 'echo -e "My first script.\n"' >>${CREATEDIRECTORY}/${BOXNAME}_scripts/my_first.sh
chmod 755 ${CREATEDIRECTORY}/${BOXNAME}_scripts/my_first.sh
fi

# generate HDF-Toolbox menu
( cd ${hdftoolpath}
  if ! grep "${BOXNAME} Tools" ${hdftoolpath}/main.cfg >/dev/null ;then
 echo -e "\n### Prepare HDF-Toolbox with \"${BOXNAME} Tools menu\" ###\n"
sed -i "8i M:menu\/${BOXNAME}:${BOXNAME} Tools" ${hdftoolpath}/main.cfg
fi

echo -e "\nGenerate ${BOXNAME} menu, scripts, cfg... symbolik link\nPlease reload the HDF-Toolbox.\n"

ln -sf ${CREATEDIRECTORY}/${BOXNAME}.cfg ${hdftoolpath}/menu/.
ln -sf ${CREATEDIRECTORY}/${BOXNAME}_menu ${hdftoolpath}/.
ln -sf ${CREATEDIRECTORY}/${BOXNAME}_scripts ${hdftoolpath}/.
cd menu
menucfg=$(ls | grep -v ${BOXNAME})
for cfg in $menucfg; do
if ! grep "M:menu/${BOXNAME}" $cfg >/dev/null;then
sed -i "/M:main:Return to Main Menu/i\M:menu/${BOXNAME}:Return to ${BOXNAME} Tools menu" $cfg
fi;done )

exit 0
