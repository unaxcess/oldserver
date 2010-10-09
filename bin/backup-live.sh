#!/bin/bash

cd `dirname $0`
echo "Now in $PWD"

DBUSER=`cat uadata.edf | grep "<dbuser=" | cut -d'"' -f2`
DBPASSWORD=`cat uadata.edf | grep "<dbpassword=" | cut -d'"' -f2`

echo "Backing up using user=$DBUSER and password=$DBPASSWORD"

$HOME/ua-run/ua-backup.sh -u $DBUSER -p $DBPASSWORD $@
