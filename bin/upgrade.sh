#!/bin/sh

importTable()
{
	TABLE=$1
	echo "delete from $1;" >> delete.sql
	echo "insert into $TABLE select * from $OLDUA.$TABLE;" >> insert.sql
}

cat /dev/null > delete.sql
cat /dev/null > insert.sql

if [ $# = 2 ] ; then
	OLDUA=$1
	NEWUA=$2

	importTable channel_item
	importTable channel_sub
	
	importTable folder_item
	importTable folder_sub
	
	importTable service_sub
	
        echo "delete from user_item;" >> delete.sql
	echo "insert into user_item \
(\
userid,usertype,name,password,accesslevel,accessname,gender,\
description,\
created,ownerid,\
client,hostname,address,location,protocol,secure,timeon,timeoff,\
numlogins,totallogins,longestlogin,nummsgs,totalmsgs,lastmsg,numvotes,\
edf\
) \
select * from $OLDUA.user_item;" >> insert.sql

	importTable channel_message_item
	
	echo "delete from folder_message_item;" >> delete.sql
	echo "insert into folder_message_item select * from $OLDUA.folder_message_item;" >> insert.sql
	echo "insert into folder_message_item select * from $OLDUA.folder_message_archive;" >> insert.sql
	
	importTable folder_message_read

        importTable user_login

        echo "Deleting"
        cat delete.sql | mysql $NEWUA -p

        echo "Inserting"
        cat insert.sql | mysql $NEWUA -p
else
	echo "Usage upgrade.sh <old db> <new db>"
fi
