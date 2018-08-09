* Chi-square test;
* Chi-square test is useful for detection of general association not particular relationship 
* between treatment and categorical response i.e ordinal and nominal in clinical trial;
* this is usually using proc freq with chisq option;
data chiTest;
    input trt $ adae $ adct;
    datalines;
Active Y 50
Active N 28
Placebo Y 30
Placebo N 78
; 
run;

* conduct chi-square test;
proc freq data=chiTest;
    table trt*adea / chisq;
    weight adct;
    output out=chstats chisq;
run;



proc logistic data=adsl;
    model aval(event="1") = baseline sexn racen trtpn 
                                / clodds = wald;
run;