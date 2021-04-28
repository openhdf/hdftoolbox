#!/bin/sh

echo "Download and install Samba4 config files"
cd /etc/samba/
curl -O http://feeds.hdfreaks.cc/extra_files/samba/smb.conf > /dev/null 2>&1
curl -O http://feeds.hdfreaks.cc/extra_files/samba/smb-user.conf > /dev/null 2>&1

cd /etc/samba/distro/
curl -O http://feeds.hdfreaks.cc/extra_files/samba/distro/smb-secure.conf > /dev/null 2>&1
curl -O http://feeds.hdfreaks.cc/extra_files/samba/distro/smb-insecure.conf > /dev/null 2>&1
curl -O http://feeds.hdfreaks.cc/extra_files/samba/distro/smb-global.conf > /dev/null 2>&1
curl -O http://feeds.hdfreaks.cc/extra_files/samba/distro/smb-shares.conf > /dev/null 2>&1
curl -O http://feeds.hdfreaks.cc/extra_files/samba/distro/smb-branding.conf > /dev/null 2>&1

echo
echo "Update Done ... Please wait ..."
echo
/etc/init.d/samba restart
echo

exit 0
