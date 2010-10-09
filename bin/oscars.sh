#!/bin/sh

if [ $# -eq 1 ] ; then
  DBPASSWORD=$1
  # echo "p=$DBPASSWORD"
  
  MYSQL="select messageid,fma.parentid,fi.name,from_unixtime(message_date),ui.name,toid,subject,message_text from folder_message_item fma,folder_item fi,user_item ui where fma.folderid=144187 and fma.message_text like '%best%' and fma.folderid = fi.folderid and fromid = ui.userid order by messageid"
  # echo "Running $MYSQL"
  
  mysql -D ua27live -e "$MYSQL" -B -s -u ua -p$DBPASSWORD >> msgs.txt
  
  echo -e "ID\tPID\tFolder\t\tDate\t\t\tFrom\t\tTo ID\tSubject" > oscars.txt
  
  cat msgs.txt |\
  while read LINE
  do
    PARENTID=`echo $LINE | cut -d' ' -f2`
    # echo Getting parent message $PARENTID
    PARENTMSG=`mysql -D ua27live -e "select messageid,fma.parentid,fi.name,from_unixtime(message_date),ui.name,toid,subject,message_text from folder_message_item fma,folder_item fi,user_item ui where fma.messageid=$PARENTID and fma.folderid = fi.folderid and fromid = ui.userid" -B -s -u ua -p$DBPASSWORD`
    echo $PARENTMSG >> oscars.txt
    echo -e "  $LINE\n" >> oscars.txt
  done
  
else
  echo "Usage: oscars.sh <password>"
fi
