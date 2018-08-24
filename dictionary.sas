
* This shows the structure of the dictionary table on the log window ;
proc sql;
describe table dictionary.tables;
quit;


* To see the contents of the dictionary ;
proc sql;
    select *
    from dictionary.dictionary;
quit;