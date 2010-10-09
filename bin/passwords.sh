#!/bin/sh

echo "Creating password file ready for security check"

echo "select userid,':',password,':0:0:user:/user:/user' from user_item where password is not null and password <> '' order by password" | mysql -s -u ua ua27live -p | perl -pli~ -e "s/\t//g" > passwords.txt
