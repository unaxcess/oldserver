#!/bin/sh

messageDay()
{
  START=$1
  END=`echo $START + 86400 | bc`
  
  NEWPOSTS=`echo "select count(*) from folder_message_item where parentid = -1 and message_date >= $START and message_date < $END" | mysql -s -u ua ua27live -pfuck88pig`
  REPLYPOSTS=`echo "select count(*) from folder_message_item where parentid > 0 and message_date >= $START and message_date < $END" | mysql -s -u ua ua27live -pfuck88pig`
  STARTSTR=`longtime $START`
  echo "messageDay $STARTSTR: $NEWPOSTS new posts, $REPLYPOSTS reply posts"
}

if [ $# -eq 2 ] ; then
  STARTDAY=$1
  COUNT=$2
else
  STARTDAY=`date +%s`
  echo "Now: $STARTDAY"
  STARTDAY=`echo $STARTDAY - 86400 | bc`
  if [ $# -eq 1 ] ; then
    COUNT=$1
  else
    COUNT=30
  fi
fi

echo "Start point: $STARTDAY"

while [ $COUNT -gt 0 ]
do
  messageDay $STARTDAY
  
  STARTDAY=`echo $STARTDAY - 86400 | bc`
  
  COUNT=`echo $COUNT - 1 | bc`
done

