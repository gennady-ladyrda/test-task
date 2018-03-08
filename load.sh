#!/bin/bash

case $1 in
  "--help")
  echo "This program loads files in database"
  echo "use -l option for load files from input directory to database"
  exit 0
  ;;
  "-l")
##################################################
  LOG="./tmp/log.txt"
  LDR_DIR="./loader"
  TMP_LOAD_TABLE="tmp_load_table"
  FILE_MASK="*.csv"
  FIELD_TERMINATE=","
  SQLLDR_PATH=`which sqlldr`
  SQLPLUS_PATH=`which sqlplus`
  SQL_SCRIPT="process.sql"
  SQL_PATH="./sql"
  IN_DIR="./in_files"
  IN_LIST="./tmp/file_list.txt"
  OUT="./done_files"
  USER="bookshelf"
  TEMP="m4dbook!"

  echo `date`>>$LOG
  echo "Start job">>$LOG
  ls -l $IN_DIR/$FILE_MASK>$IN_LIST 2>>$LOG
  #check files in input directory
  if [ -s $IN_LIST ]
  then
    for file in $IN_DIR/$FILE_MASK
    do
      if [ -f "$file" ]
      then
      filename=$(basename "$file")
      ctl_file=$LDR_DIR/ctl/$filename".ctl"
      {
      echo "OPTIONS (SKIP=1)"
      echo "LOAD DATA"
      echo "CHARACTERSET UTF8"
      echo "INFILE '$file'"
      echo "BADFILE '$LDR_DIR/bad/$filename.bad'"
      echo "DISCARDFILE '$LDR_DIR/dsc/$filename.dsc'"
      echo "APPEND"
      echo "INTO TABLE $TMP_LOAD_TABLE"
      echo "FIELDS TERMINATED BY '$FIELD_TERMINATE'"
      echo "TRAILING NULLCOLS"
      echo "("
      echo "author,"
      echo "book,"
      echo "reader,"
      echo "reader_birthday date \"dd-mm-yyyy\" "
      echo ")"
      } > $ctl_file
      $SQLLDR_PATH $USER/$TEMP control=$ctl_file log=$LDR_DIR/log/$filename".log"
      mv $file $OUT
      fi
    done
    $SQLPLUS_PATH -s $USER/$TEMP @$SQL_PATH/$SQL_SCRIPT
    rm $IN_LIST
  else 
    echo "There are no files in input directory."
    exit 0
  fi
##################################################
  ;;
  *)
  echo "type $0 --help for help"
  exit 0
esac


