#!/bin/sh
echo "IPTV Italy Bouquet Download"
curl -O https://raw.githubusercontent.com/pixbox-hdf/HDFreaks/master/IPTV/userbouquet.iptv_italy.tv > /dev/null 2>&1
if [ $? -eq 0 -a -s /home/root/userbouquet.iptv_italy.tv ]; then
		rm -rf /etc/enigma2/userbouquet.iptv_italy.tv
		mv -f /home/root/userbouquet.iptv_italy.tv /etc/enigma2/userbouquet.iptv_italy.tv
		chmod 644 /etc/enigma2/userbouquet.iptv_italy.tv
		wget -qO - http://127.0.0.1/web/servicelistreload?mode=0 > /dev/null 2>&1
		echo ""		
	else
	exit 1
fi
exit 1

