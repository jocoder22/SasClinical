********************************************************************
* Program name:
* Output name: t_demog
* Programmer:
* Date:
* Reviewer:
* Review Date:
* Title:
*********************************************************************

* Double the entire data to generate the value holder for the overall data;
* This is based on the new overall treatment group, with value 9;
data demog;
    set sasuser.demog;
    output; * this output original data;
    trt = 9; * this generate value holder for overall group;
    output; * this add the overall treatment group per observation;
run;



* sort the data by treatment groups;
proc sort data=demog;
    by trt;
run;



* Generate age statistics by treatment groups;
proc summary data=demog;
    by trt;
    var age;
    output out=age1 n=_N mean=_mean st=_std median=_mdn min=_mn max=_mx;
run;



* Concatenate variable;
data age2;
    set age1;
    meansd = put(_mean,4.1)||'('||put(_std,5.2)||')';
    mnmx = put(_mn,3.0)||','||put(_mx,3.0);
    N = put(_n,3.0);
    median = put(_mdn,4.1);
    drop _:;
run;



* Transpose data;
proc transpose data=age2 out=age3;
    id trt;
    var n meansd median mnmx;
run;


* Generate values for _name_;
data age4;
    length newvar$ 30.;
    set age3;
    if _name_ = 'N' then newvar='  N';
    else if _name_ = 'meansd' then newvar='  Mean(SD)';
    else if _name_ = 'median' then newvar='  Median';
    else if _name_ = 'mnmx' then newvar='  Min,Max';
    drop _name_;
run;


data dummy;
    length newvar$ 30.;
    newvar = 'Age(years)';
run;

data age;
    set dummy age4;
    ord = 1;
run;





* Gender statistics;
proc freq data=demog noprint;
    by trt;
    table gender/out=gen1;
    where gender ne .;
run;


data gen2;
    set gen1;
    np = put(count,3.0)||'('||put(percent,4.1)||')';
run;

proc sort data=gen2;
    by gender;
run;


proc transpose data=gen2 out=gen3;
    id trt;
    var np;
    by gender;
run;

data gen4;
    length newvar$ 30.;
    set gen3;
    if gender=1, the newvar='  Male';
    else if gender=2 then newvar='  Female';
    drop gender _name_;
run;


data dummy;
    length newvar$ 30.;
    newvar='Gender[n(%)]';
run;

data gender;
    set dummy gen4;
    ord=2;
run;




* Ethnic statistics;
proc freq data=demog noprint;
    by trt;
    table ethnic/out=ethnic1;
    where ethnic ne .;
run;


data ethnic2;
    set ethnic1;
    np = put(count,3.0)||'('||put(percent,4.1)||')';
run;

proc sort data=ethnic2;
    by ethnic;
run;


proc transpose data=ethnic2 out=ethnic3;
    id trt;
    var np;
    by ethnic;
run;

data ethnic4;
    length newvar$ 30.;
    set gen3;
    if ethnic=1, the newvar='  Hispanic or Latino';
    else if ethnic=2 then newvar='  Not Hispanic or Latino';
    drop ethnic _name_;
run;


data dummy;
    length newvar$ 30.;
    newvar='Ethnicity[n(%)]';
run;

data ethnic;
    set dummy ethnic4;
    ord=3;
run;




* Race statistics;
proc freq data=demog noprint;
    by trt;
    table Race/out=Race1;
    where Race ne .;
run;


data Race2;
    set Race1;
    np = put(count,3.0)||'('||put(percent,4.1)||')';
run;

proc sort data=Race2;
    by Race;
run;


proc transpose data=Race2 out=Race3;
    id trt;
    var np;
    by Race;
run;

data Race4;
    length newvar$ 30.;
    set Race3;
    if Race=1, the newvar='  White';
    else if Race=2 then newvar='  Black or African American';
    else if Race=3 then newvar='  Asian';
    drop Race _name_;
run;


data dummy;
    length newvar$ 30.;
    newvar='Race[n(%)]';
run;

data Race;
    set dummy Race4;
    ord=4;
run;


*  Final dataset;
data final;
    set age gender ethnic race;
run;


* Creating the final report;
options nocenter nodate nonumber; title;
proc report data=final nowd headline headskip split='*';
    column('--' ord newvar _0 _1 _9);
    define ord/ order noprint;
    break after ord/ skip;
    define newvar/ '';
    define _1/ 'BP3304*(N=31)';
    define _0/'Placebo*(N=29)';
    define _9/'Overall*(N=60)';
    compute before _page_;
        line @10 '14.1.2.1 Subject Demographics and baseline characteristics';
        line @40 'Safety Population';
    endcomp;
     compute before _page_;
        line @2 70*'-';
        line @3 'Reference: Listing 16.4.2.1';
        line @5 'Percentages are based on the number of subjects in the Population';
        line @3 'Note: SD = standard deviation, Min = Minimum, Max = Maximum';
    endcomp;
run;

