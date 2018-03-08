Assumptions:
1) Input files contain facts about readers' actions.
2) Every fact must be processed. Repeating the fact in the input means that the reader took the book again.
3) If new Author, Book or Reader were discovered, new rows will be added in appropriate tables.
Installation:
1) To install, unpack the archive in a separate directory.
2) It is necessary create the user and schema objects in the database before you can use it. There are scripts in "sql/init".
Use:
1) File "load.sh" loads CSV files from "in_files" and moves its in "done_files". Use "load.sh -l" command.
2) Files samples are located in the input direcory "in_files".
3) File "reports.sh" creates reports from third task part in directory "reports".