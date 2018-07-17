libname home "C:\Users\Jose\Documents\SasClinical";
filename listing3 "C:\Users\Jose\Documents\SasClinical\listing3";


* Listing using macros;
* First double the dataset;
data adsl;
    set home.adsl; output;
    trt01an=9; output;
run;




%macro listtm(var=, title=, num=);
proc summmary data=adsl;
    class trt01an;
    var &var.;
    output out=&var._1 (where=(trt01an ne .))
        n=_n mean=_mean std=_std median=_median min=_mn max=_mx;
run;

data &var._2;
    set &var._1;
    meansd=put(_mean,4.1)||'('||put(_std,5.2)||')';
    mnmx=put(_mn,3.0)||','||put(_mx,3.0);
    n=put(_n,3.0);
    median=put(_median,4.1);
    drop _:;
run;


proc transpose data=&var._2 out=&var._3;
    id trt01an;
    var n meansd median mnmx;
run;



data &var._4;
    length newvar$ 30.;
    set &var._3;
    if _name_='n' then newvar='   N';
    else if _name_='meansdn' then newvar='   Mean(SD)';
    else if _name_='mnmxn' then newvar='   Min, Max';
    else if _name_='meadian' then newvar='   Median';
    drop _name_;
run;


data dummy;
    length newvar$ 30.;
    newvar=&title;
run;


data &var.;
    set dummy &var._4;
    ord=&num;
run;


proc dataset lib=work nolist;
    delete &var._: dummy;
run;
%mend;



* Calling the macro;
* Calling macro for height statistics;
%listtm(var=height,title="Height(cm)",num=1);

* Calling macro for height statistics;
%listtm(var=weight,title="Weight(kg)",num=2);

* Calling macro for height statistics;
%listtm(var=bmi,title="Body Mass Index(kg/m^2)",num=3);



* Final dataset;
data final;
    set height weight bmi;
run;

proc sql noprint;
    select count(distinct subjid) into: N1-: N3 from adsl
    group by trt01an;
quit;

proc report data=final nowd headskip headline skip='*';
    column ('--' ord newvar _1 _0 _9);
    define ord/order noprint;
    break after ord/skip;
    define newvar/'';
    define _1/"BP3304*(N=&n2)";
    define _0/"Placebo*(N=&n1)";
    define _9/"Overall*(N=&n3)";
run;