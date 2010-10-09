#!/bin/sh

inctotal()
{
  # echo "$TOTAL + 1"
  TOTAL=`echo "$TOTAL + 1" | bc`
}

messageThread()
{
  MSGTYPE=$1
  MSGID=$2
  INDENT=$3
  
  # echo "messageThread $MSGTYPE $MSGID"
  
  FILE=/tmp/$MSGTYPE$MSGID.txt

  mysql -D ua27live -e "select messageid,fma.parentid,fi.name,from_unixtime(message_date),u1.name,toid,subject,message_text from folder_message_item fma,folder_item fi,user_item u1 where fma.$MSGTYPE = $MSGID and fma.folderid = fi.folderid and fromid = u1.userid order by messageid;" -B -s -u ua -p$DBPASSWORD > $FILE
  
  # echo "File has `cat $FILE | wc -l | sed -e "s/ //g"` lines"
  # cat $FILE

  cat $FILE |\
  while read LINE
  do
    inctotal
    echo -e "$INDENT$LINE"
    PARENTID=`echo $LINE | cut -d' ' -f1`
    # echo "Parent ID: $PARENTID"
      
    messageThread parentid $PARENTID "$INDENT  "
  done
}

TOTAL=0

\rm -f /tmp/messageid*.txt /tmp/parentid*.txt

if [ $# -eq 2 ] ; then
  DBPASSWORD=$1
  MESSAGEID=$2
  
  echo -e "ID\tPID\tFolder\t\tDate\t\t\tFrom\t\tTo ID\tSubject"

  messageThread messageid $MESSAGEID
  
  echo "Total messages: $TOTAL"
else
  echo "Usage: message_thread.sh <password> <message ID>"
fi
