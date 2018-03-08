#!/bin/bash
SQLPLUS_PATH=`which sqlplus`
SQL_PATH="./sql"
USER="bookshelf"
TEMP="m4dbook!"
echo "This program creates reports."
while [ 1 ]
do
  echo "--Input menu number to continue:"
  echo "  1: All authors that wrote at least 1 book"
  echo "  2: Number of readers born in each year"
  echo "  3: 3 the most popular authors with their popularity"
  echo "  4: exit"
read doing
case $doing in
  1) $SQLPLUS_PATH -s $USER/$TEMP @$SQL_PATH/report1.sql ;;
  2) $SQLPLUS_PATH -s $USER/$TEMP @$SQL_PATH/report2.sql ;;
  3) $SQLPLUS_PATH -s $USER/$TEMP @$SQL_PATH/report3.sql ;;
  4) exit 0 ;;
  *) echo "---Not supported command---" ;;
esac
done

