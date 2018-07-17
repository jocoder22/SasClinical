libname report4 "C:\Users\Jose\Documents\SasClinical";
%let myrp4=C:\Users\Jose\Documents\SasClinical\listing4;


* Double the dataset;
data admin;
    set report4.admin1; output;
    trt=9; output;
run;

