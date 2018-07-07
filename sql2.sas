libname home "C:\Users\Jose\Documents\SasClinical\sql2";

proc sql;
    create table sqlTable1 (name char(10), age num, gender char);
quit;


* fill table with with values;
proc sql;
    insert into sqlTable1
        values('Mary', 56, 'F')
        values('John', 67, 'M')
        values('Anna', 43, 'F')
        ;
quit;
