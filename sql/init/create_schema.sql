create user bookshelf IDENTIFIED by "m4dbook!";

alter user bookshelf quota 50M on users;
grant create session to bookshelf;
grant create table to bookshelf;
grant create procedure to bookshelf;
grant create sequence to bookshelf;
grant alter any table to bookshelf;
grant alter any procedure to bookshelf;
grant delete any table to bookshelf;
grant drop any table to bookshelf;
grant drop any procedure to bookshelf;
grant drop profile to bookshelf;