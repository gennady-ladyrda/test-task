set term off
set linesize 999
set wrap on
spool ./reports/1.rep
      select a.AUTHOR_NAME, count(*) number_of_books from authors a, books b
       where a.athr_id = b.athr_id
      group by a.AUTHOR_NAME
      having count(*) >= 1
      order by 2 desc;
spool off
exit

