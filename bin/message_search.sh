#!/bin/sh

messageSearch()
{
  DB=$1
  TABLE=$2
  
  QUERY="select "
  if [ $COUNT = 1 ] ; then
    QUERY=$QUERY"count(*)"
  else
    QUERY=$QUERY"messageid,$TABLE.parentid,folder_item.name,from_unixtime(message_date),user_item.name,toid,subject,message_text"
  fi
  
  QUERY=$QUERY" from $TABLE,folder_item,user_item where";
  
  if [ $ID -gt 0 ] ; then
    QUERY=$QUERY" messageid = $ID";
  else  
    QUERY=$QUERY" (message_text like '%$TEXT%' or subject like '%$TEXT%')";
    
    if [ $FOLDER -gt 0 ] ; then
      QUERY=$QUERY" and $TABLE.folderid = $FOLDER"
    fi
  
    if [ $PRIVATE -eq 0 ] ; then
      QUERY=$QUERY" and $TABLE.folderid <> 384"
    fi

    if [ $USER -gt 0 ] ; then
      QUERY=$QUERY" and fromid = $USER"
    fi
    
    if [ $PARENTID -gt 0 ] ; then
      QUERY="$QUERY and $TABLE.parentid = $PARENTID"
    fi
    
    if [ $DATE -gt 0 ] ; then
      QUERY="$QUERY and $TABLE.message_date >= $DATE"
    fi
  fi
  
  QUERY=$QUERY" and $TABLE.folderid = folder_item.folderid and $TABLE.fromid = user_item.userid order by messageid"
  
  echo "Searching $TABLE in $DB using $QUERY..."
  
  echo "$QUERY;" | mysql -u ua $DB -p$PASSWORD
}

if [ $# -ge 1 ] ; then
  COUNT=0
  PASSWORD=""
  USER=0
  ID=0
  PRIVATE=0
  FOLDER=0
  PARENTID=0
  DATE=""

  while [ $# -gt 1 ] ; do
    echo "Cmd: $1"
    
    if [ "$1" = "-p" ] ; then
      PASSWORD=$2
      shift
    elif [ "$1" = "-u" ] ; then
       USER=$2
       shift
    elif [ "$1" = "-f" ] ; then
       FOLDER=$2
       shift
    elif [ "$1" = "-c" ] ; then
       COUNT=1
    elif [ "$1" = "-m" ] ; then
      ID=$2
    elif [ "$1" = "-pr" ] ; then
      PRIVATE=1
    elif [ "$1" = "-pi" ] ; then
      PARENTID=$2
      shift
    elif [ "$1" = "-d" ] ; then
      DATE=$2
      shift
    fi
    
    shift
  done
  
  TEXT=$1
  
  echo "PW: $PASSWORD, FROM: $FROM, $ID, COUNT: $COUNT"

  messageSearch ua27live folder_message_item
  # echo ""

  # messageSearch ua25live message_item
  # messageSearch ua25live message_item_archive
  # echo ""

  # messageSearch ua-live folder_message_archive
else
  echo "Usage: message_search.sh [-p <password>] [-c] [-m <ID>] [-pi <ID>] [-pr] [-f <folder>] [-u <user>] [<text>]"
fi
