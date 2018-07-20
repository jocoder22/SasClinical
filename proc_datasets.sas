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
quit;
run;


* Deleting or save/delete datasets;
proc datasets lib=newdb nolist;
    delete bmi height;
quit;
run;

proc datasets lib=newdb nolist kill;
quit;
run;

proc datasets lib=newdb nolist;
    save final; *delete all except final;
quit;
run;


* Modifying datasets;
* 1. label dataset;
* Using data step;
data newdb.bmi(label="Body Mass Index");
    set newdb.bmi;
run;


* Using proc datasets, which is faster and more efficient;
proc datasets lib=newdb nolist;
    modify height(label="Height of Students");
quit;
run;


* 2. label variables;
* using data step;
data newdb.bmi;
    set newdb.bmi;
    label height="Heights of Students"
          weight="Weights of Students";
run;

* using proc datasets which is faster and more efficient;
proc datasets lib=newdb nolist;
    modify bmi;
        label height="Heights in cm"
              weight="Weights in pounds";
quit;
run;


* 3. rename variables and apply formats/informats;
* using data step;
data newdb.visit;
    set newdb.visit(rename=(inv=site pat=subj));
    format todate fromdate mmddyy10.;
    informat vstdate todate fromdate mmddyy10.;
run;


proc datasets lib=newdb nolist;
    modify visit;
        rename inv=site pat=subj;
        format todate fromdate mmddyy10.;
        informat vstdate todate fromdate mmddyy10.;
quit;
run;

