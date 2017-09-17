#!/bin/sh

echo "Download and install Samba4 config files"
cd /etc/samba/
curl -O https://raw.githubusercontent.com/oe-alliance/oe-alliance-core/4.1/meta-oe/recipes-connectivity/samba/samba-4.%25/smb.conf > /dev/null 2>&1

cd /etc/samba/distro/
curl -O https://raw.githubusercontent.com/oe-alliance/oe-alliance-core/4.1/meta-oe/recipes-connectivity/samba/samba-4.%25/openhdf/smb-shares.conf > /dev/null 2>&1
curl -O https://raw.githubusercontent.com/oe-alliance/oe-alliance-core/4.1/meta-oe/recipes-connectivity/samba/samba-4.%25/openhdf/smb-branding.conf > /dev/null 2>&1

echo
echo "Update Done ... Please wait ..."
echo
/etc/init.d/samba restart
echo

exit 0   
