* Double the entire data to generate the value holder for the overall data;
* This is based on the new overall treatment group, with value 9;
data demog;
    set sasuser.demog;
    output; * this output original data;
    trt = 9; * this generate value holder for overall group;
    output; * this add the overall treatment group per observation;
run;


* sort the data by treatment groups;
proc sort data=demog out=demog1;
    by trt;
run;



* Generate age statistics by treatment groups;
proc summary data=demog1;
    by trt;
    var age;
    output out=age1 n=_N mean=_mean st=_std median=_mdn min=_mn max=_mx;
run;