libname home "C:\Users\Jose\Documents\SasClinical";
filename listing3 "C:\Users\Jose\Documents\SasClinical\listing3";


* Listing using macros;
* First double the dataset;
data adsl;
    set sasuser.adsl; output;
    trt01an=9; output;
run;


proc summmary data=adsl;
    class trt01an;
    var height;
    output out=ht_1 (where=(trt01an ne .))
        n=_n mean=_mean std=_std median=_median min=_mn max=_mx;
run;

