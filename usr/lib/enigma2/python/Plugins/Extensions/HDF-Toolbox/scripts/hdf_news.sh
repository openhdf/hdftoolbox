#!/bin/sh

cd /tmp
rm -f /tmp/news.txt
wget http://feeds.hdfreaks.cc/news.txt > /dev/null 2>&1

if [ -f /tmp/news.txt ]; then
		cat /tmp/news.txt
		echo
else
		echo
		echo "Sorry, there are currently no HDF news available"
		echo
fi

exit 0
