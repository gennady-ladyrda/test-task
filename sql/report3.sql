set term off
set linesize 999
set wrap on
spool ./reports/3.rep
  select author_name
    from (select a.author_name, a.athr_id, count(*), row_number() over (order by count(*) desc) as rnk
            from (select b.athr_id from facts f, books b where b.book_id = f.book_id) fb, authors a
          where a.athr_id = fb.athr_id
          group by a.ATHR_ID, a.author_name) author_rank
  where rnk <= 3;
spool off
exit

