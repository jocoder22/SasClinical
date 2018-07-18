libname report4 "C:\Users\Jose\Documents\SasClinical";
%let myrp4=C:\Users\Jose\Documents\SasClinical\listing4;


* Double the dataset;
data admin;
    set report4.admin1; output;
    trt=9; output;
run;


data left;
    length label$ 50.;
    ord=1; label='No. of subjects who completed Treatment'; output;
    ord=2; label='No. of subjects who discontinued Treatment'; output;
    ord=3; sord=0; label='           Reasons for discontinuation:'; output;
    ord=3; sord=1; label='           Adverse Event'; output;
    ord=3; sord=2; label='           Lack of Efficacy'; output;
    ord=3; sord=3; label='           Lost to Followup'; output;
    ord=3; sord=4; label='           Withdrew Consent'; output;
    ord=3; sord=5; label='           Adminstrative'; output;
    ord=3; sord=6; label='           Protocol Violation'; output;
run;


proc sql;
    create table count as 
    select count(distinct subjid) as n, trt, 1 as ord from admin
        where complyn=1 group by trt
    union all
    select count(distinct subjid) as n, trt, 2 as ord from admin
        where complyn=2 group by trt
    union all
    select count(distinct subjid) as n, trt, 3 as ord, discn as sord from admin
        where complyn=2 group by trt, discn
    order by trt;
quit;

proc sql;
    create table demon as 
    select count(distinct subjid) as bign, trt from admin
    group by trt;
    order by trt;
quit;


data new;
    merge count denom;
    by trt;
    np=put(n,3.0)||'('||put((n/bign)*100,4.1)||')';
run;

proc sort data=new;
    by ord sord;
run;

proc transpose data=new out new1;
    id trt;
    var np;
    by ord sord;
run;


proc sort data=left;
    by ord sord;
run;

proc sort data=new1;
    by ord sord;
run;
