#!/bin/sh
### BEGIN INIT INFO
# Provides: kernel
# Default-Start:  2345
# Default-Stop:   016
# Short-Description: disable/enable ipv6 on all interfaces.
# 					 disable/enable rdnssd (IPv6 Recursive DNS Server discovery)
#                    RDNSS daemon for autoconfiguration of IPv6 DNS resvolers.
# Description: IPv6 protocol stack for Linux
### END INIT INFO
### by nomjasV for openHDF

case "$1" in
start)
	echo -n "Disable ipv6 on all interfaces... "
	echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
    #/sbin/sysctl -w net.ipv6.conf.all.disable_ipv6=1
	echo -e "done.\n"
	;;

stop)
	echo -n "Enable ipv6 on all interfaces... "
	echo 0 > /proc/sys/net/ipv6/conf/all/disable_ipv6
	#/sbin/sysctl -w net.ipv6.conf.all.disable_ipv6=0
	echo -e "done.\n"
	;;

disable)
        if [ -L /etc/init.d/ipv6 ]; then
         echo -e "ipv6 is disabled, exit...\n"
        exit 1
        fi
        ln -sf /usr/lib/enigma2/python/Plugins/Extensions/HDF-Toolbox/scripts/ipv6.sh /etc/init.d/ipv6
           /usr/sbin/update-rc.d -f ipv6 defaults
          /etc/init.d/ipv6 start
         kill -9 $(pidof -s odhcp6c) >/dev/null 2>&1
         [ -d /etc/network/disabled ] || mkdir /etc/network/disabled
         mv /etc/network/if-down.d/odhcp6c /etc/network/disabled/ifdownd-odhcp6c
         mv /etc/network/if-up.d/odhcp6c /etc/network/disabled/ifupd.odhcp6c
        echo "done."
        ;;

enable)
        if [ ! -L /etc/init.d/ipv6 ]; then
         echo -e "ipv6 is not disabled, exit...\n"
        exit 1
        fi
           /etc/init.d/ipv6 stop
          /usr/sbin/update-rc.d -f ipv6 remove
        rm -f /etc/init.d/ipv6
       mv /etc/network/disabled/ifdownd-odhcp6c /etc/network/if-down.d/odhcp6c
       mv /etc/network/disabled/ifupd.odhcp6c /etc/network/if-up.d/odhcp6c
       rm -rf /etc/network/disabled
     echo -e "\nPlease reboot your $(uname -n) BOX...\n "
	 echo "done."
        ;;

*)
	echo -e "\nUsage: /etc/init.d/$0 {start|stop|disable|enable}"
	exit 1
	;;
esac

exit 0
