
* This shows the structure of the dictionary table on the log window ;
proc sql;
    describe table dictionary.tables;
quit;


* Using sashelp.vtable to show the structure of dictionary table ;
proc sql;
    describe view sashelp.vtable;
quit;


* describes the structure of data and view ;
proc sql;
    select libname, memname, memtype
    from dictionary.members
    where memtype in ('DATA', 'VIEW')
    order by libname asc, memname asc;
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




/* This describes the properties of the columns in the table dataset NNN */
/* this uses sql procedure */
proc sql;
    create table mytable2 as 
    select * from sashelp.vcolumn 
    where libname='WORK' and memname='NNN';
quit;



* Describe all dataset, views, catalogs and templates in all libraries ;
proc sql;
    create table mytable3 as 
    Select * from dictionary.dictionaries;
quit;



/* This displays the occurances of column names in libnames except maps and sashelp */
proc sql;
    select name, count(*) as Frequency
    from dictionary.columns where libname not in ('MAPS', 'SASHELP') 
    group by name
    having count(*) > 1 
    order by Frequency DESC;
quit;


* display number of observations in all dataset in libname sashelp and sasuser ;
proc sql;
    select libname, memname, nobs 'Number of Observations'
    from dictionary.tables
    where libname in ('SASHELP', 'SASUSER')
    order by nobs desc;
quit;