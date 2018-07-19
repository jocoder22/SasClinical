libname home "C:\Users\Jose\Documents\SasClinical";
libname newdb "C:\Users\Jose\Documents\SasClinical\Newdata";

proc datasets;
quit;
run;

proc datasets lib=home;
quit;
run;

proc contents data=home._all_ nods;
run;



* Getting details of datasets;
proc datasets lib=home;
    contents data=_all_;
quit;
run;

proc contents data=_all_;
run;



* Coping dataset;
proc copy in=mylib out=newdb;
run;

proc datasets nolist;
    copy in=mylib out=newdb;
run;



* Selecting datasets ;
proc copy in=mylib out=newdb;
    select bmi height final;
run;

proc datasets nolist;
    copy in=mylib out=newdb;
    select bmi height final;
run;