#!/bin/sh

COUNT=`\ls -1 ICE.*.txt 2> /dev/null | wc -l`
echo "$COUNT output files"
if [ $COUNT -gt 0 ] ; then
  HEAD=`echo "$COUNT - 1" | bc`
  # echo "Head: $COUNT -> $HEAD"
  FILES=`\ls -1 ICE.*.txt | head -$HEAD`
  # echo -e "Files:\n$FILES"
else
  HEAD=0
  FILES=""
fi

if [ ! -e panic_output ] ; then
  echo "Creating panic_output"
  mkdir panic_output
fi

if [ ! -e normal_output ] ; then
  echo "Creating normal_output"
  mkdir normal_output
fi

echo "Checking $HEAD output files"
for FILE in $FILES
do
  # echo "Checking $FILE"
  GREP=`grep "^Panic" $FILE`
  if [ "$GREP" != "" ] ; then
    echo "Found panic in $FILE"
    mv $FILE panic_output
  else
    mv $FILE normal_output
  fi
done
