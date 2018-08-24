
* This shows the structure of the dictionary table on the log window ;
proc sql;
describe table dictionary.tables;
quit;


* To see the contents of the dictionary ;
proc sql;
    create table1 as 
    select *
    from dictionary.dictionary;
quit;


/* This display the libraries and their contents */
/* this include data, catalog, views, itemstor */
proc sql;
    select * from dictionary.members;
quit;



/* This describles the properties of dataset NNN */
data mytable;
set sashelp.vtable;
where libname='WORK' and memname='NNN';
run;

/* This describes the properties of the columns in the table dataset NNN */
/* this uses data set step */
data mytableC;
set sashelp.vcolumn;
where libname='WORK' and memname='NNN';
run;