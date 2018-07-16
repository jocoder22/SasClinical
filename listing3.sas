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

data ht_2;
    set ht_1;
    meansd=put(_mean,4.1)||'('||put(_std,5.2)||')';
    mnmx=put(_mn,3.0)||','||put(_mx,3.0);
    n=put(_n,3.0);
    meadian=put(_median,4.1);
    drop _:;
run;


proc transpose data=ht_2 out=ht_3;
    id trt01an;
    var n meansd median mnmx;
run;



data ht_4;
length newvar$ 30.;
    set ht_3;
    if _name_='n' then newvar='   N';
    else if _name_='meansdn' then newvar='   Mean(SD)';
    else if _name_='mnmxn' then newvar='   Min, Max';
    else if _name_='meadian' then newvar='   Median';
    drop _name_;
run;


data dummy;
    length newvar$ 30.;
    newvar='Height(cm)';
run;

data height;
    set dummy ht_4;
    ord=1;
run;
    
