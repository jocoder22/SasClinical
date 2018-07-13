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


data age2;
    set age1;
    meansd = put(_mean,4.1)||'('||put(_std,5.2)||')';
    mnmx = put(_mn,3.0)||','||put(_mx,3.0);
    N = put(_n,3.0);
    median = put(_mdn,4.1);
    drop _:;
run;