options firstobs=1 obs=1 pageno=1 ls=180 ps=100;
libname home "C:\Users\Jose\Documents\SasClinical";


proc sql;
    select Subid, Studyid, Gender
        from home.double
        where Age < 40
        group by Gender
        Order by Age;
quit;
