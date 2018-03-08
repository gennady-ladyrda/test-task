create or replace procedure dirty_data_process (use_mode in varchar2 default null) is
    begin
       /*First find new authors*/
       insert into authors (author_name) (
         select  distinct(t.author) as author_name from tmp_load_table t where not exists 
           (select 1 from authors a where t.author = a.author_name))
       LOG ERRORS INTO authors_errors REJECT LIMIT 999;
       /*Find new books*/
       insert into books (book_name, athr_id) (
         select distinct(t.book), a.athr_id from tmp_load_table t, authors a  where not exists 
           (select 1 from books a where t.book = a.book_name)
           and a.author_name = t.author)
       LOG ERRORS INTO books_errors REJECT LIMIT 999;
       /*Find new readers*/
       insert into readers (reader_name, birthday) (
         select distinct(t.reader), t.reader_birthday from tmp_load_table t where not exists
          (select 1 from readers a where t.reader = a.reader_name))
       LOG ERRORS INTO readers_errors REJECT LIMIT 999;
       /*Load all new facts*/
       insert into facts (book_id, read_id) (
         select b.book_id, r.read_id from tmp_load_table t
           join books b on t.book = b.book_name
           join readers r on t.reader = r.reader_name)
       LOG ERRORS INTO facts_errors REJECT LIMIT 999;
       commit;
       execute immediate 'truncate table tmp_load_table';
    end dirty_data_process;
/