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