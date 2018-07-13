proc sort data=sasuser.demog out=demog;
    by trt;
run;


proc summary data=demog;
    by trt;
    var age;
    output out=age1 n=_N mean=_mean st=_std median=_mdn min=_mn max=_mx;
run;