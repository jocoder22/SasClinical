* using lag and diff function;
* lag function returns the value of previous variable;
* diff function returns the diff between current and previous value of variable;
libname home2 "C:\Users\Jose\Documents\SasClinical\chapter2"; 

data home.testLG;
    infile datalines;
    input ID $ week Wt @@;
    datalines;
101 1 234 101 2 236 101 3 240 101 4 242
102 1 238 102 2 236 102 3 235
103 1 250 103 2 251 103 3 252
104 1 248 104 2 250
105 1 180 105 2 190
;
run;


proc sort data=home.testsort out=home.testsort;
    by ID;
run;


data home.lagdiff;
    set home.testsort;
    by ID;
    lagg = lag(wt);
    diff = dif(wt);
    P_change = diff / lagg * 100;
    if first.ID then P_change = 0;
run;


data _null_;
    floorme = 123.98;
    ceilme = 289.33;
    roundme = 345.45;
    floorm = floor(floorme);
    ceilm = ceil(ceilme);
    roundm = round(roundme);
    put floorme= ceilme= roundme=;
    put floorm= ceilm= roundm=;
run;