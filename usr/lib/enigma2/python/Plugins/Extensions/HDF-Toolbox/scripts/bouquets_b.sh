#!/bin/sh

cd /etc/enigma2/
ls lamedb *bouquet* *.xml *mp* >/tmp/hdf_b.cfg

# clanup timer
echo -e "find <log code= in /etc/enigma2/timers.xml and remove this\n"
sed -i '/log code\=/d' /etc/enigma2/timers.xml

echo -e "Backup your Bouquets/Timers/Automounts from /etc/enigma2/ to HDD\n"
[ -d /hdd/backup ] || mkdir /hdd/backup
tar -czf /hdd/backup/HDF_Backup.tar.gz --files-from=/tmp/hdf_b.cfg 2> /dev/null
echo -e "\nBackup complete\nYou can find your Backup now in /hdd/backup/HDF_Backup.tar.gz\n\n"
