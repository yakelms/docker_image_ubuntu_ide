#!/bin/bash
if [ ! $# = 1 ]
then
	echo "usage $0 <your ip address>"
	exit
fi

curl http://freeapi.ipip.net/$1
echo
exit
