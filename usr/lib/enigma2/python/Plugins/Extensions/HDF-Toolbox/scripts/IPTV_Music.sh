#!/bin/sh
echo "IPTV Music Bouquet Download"
curl -O https://raw.githubusercontent.com/pixbox-hdf/HDFreaks/master/IPTV/userbouquet.iptv_music.tv > /dev/null 2>&1
if [ $? -eq 0 -a -s /home/root/userbouquet.iptv_music.tv ]; then
		rm -rf /etc/enigma2/userbouquet.iptv_music.tv
		mv -f /home/root/userbouquet.iptv_music.tv /etc/enigma2/userbouquet.iptv_music.tv
		chmod 644 /etc/enigma2/userbouquet.iptv_music.tv
		wget -qO - http://127.0.0.1/web/servicelistreload?mode=0 > /dev/null 2>&1
		echo ""		
	else
	exit 1
fi
exit 1

