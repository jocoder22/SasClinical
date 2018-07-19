libname home "C:\Users\Jose\Documents\SasClinical";

proc datasets;
quit;
run;


proc datasets lib=home;
quit;
run;

proc contents data=home._all_ nods;
run;