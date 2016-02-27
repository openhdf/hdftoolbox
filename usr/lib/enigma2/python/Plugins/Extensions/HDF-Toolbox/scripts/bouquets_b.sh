#!/bin/sh

cd /etc/enigma2/
echo "lamedb" > /tmp/hdf_b.cfg
ls lamedb *bouquet* *.xml >/tmp/hdf_b.cfg

echo -e "Backup your Bouquets/Timers/Automounts from /etc/enigma2/ to HDD\n"
echo
[ -d /hdd/backup ] || mkdir /hdd/backup
	tar -czf /hdd/backup/HDF_Backup.tar.gz --files-from=/tmp/hdf_b.cfg 2> /dev/null
echo
echo "Backup complete"
echo -e "\nBackup complete\nYou can find your Backup now in /hdd/backup/HDF_Backup.tar.gz\n\n"
echo
echo