options firstobs=1 obs=1 pageno=1 ls=180 ps=100;
libname home "C:\Users\Jose\Documents\SasClinical";


/* Creating SQL Queries */
proc sql;
    select Subid, Studyid, Gender, Age
        from home.double
        where Age < 40
        group by Gender
        Order by Age;
quit;


/* Querying multiple tables */