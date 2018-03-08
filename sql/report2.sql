set term off
set linesize 999
set wrap on
spool ./reports/2.rep
 select count(*) number_of_readers, to_char(birthday, 'YYYY') year_of_birthday from readers
 group by to_char(birthday, 'YYYY')
 order by count(*) desc,to_char(birthday, 'YYYY');
spool off
exit

