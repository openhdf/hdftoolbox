#!/bin/sh

echo -e "Restore your Bouquets/Timers/Automounts from HDD to /etc/enigma2/\n"

if [ -f /hdd/backup/HDF_Backup.tar.gz ]; then
	echo "Backup found ... restore now"
	cd /etc/enigma2
	init 4
	sleep 1
	rm -f *bouquet* lamedb automounts.xml *timer*
	tar xzf /hdd/backup/HDF_Backup.tar.gz
	echo -e "\nRestore complete\nPlease wait ... restart GUI\n\n"
	sleep 2
	init 3
else
	echo -e "No backup /hdd/backup/HDF_Backup.tar.gz found"\!"\nCan't restore old data\n"
fi
exit 0
