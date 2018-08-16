* using lag and diff function;
* lag function returns the value of previous variable;
* diff function returns the diff between current and previous value of variable;
libname home2 "C:\Users\Jose\Documents\SasClinical\chapter2"; 

data home.testLG;
    infile datalines;
    input ID $ week Wt @@;
    datalines;
101 1 234 101 2 236 101 3 240 101 4 242
102 1 238 102 2 236 102 3 235 102 4 248 102 5 250
103 1 250 103 2 251 103 3 252
104 1 248 104 2 250 104 5 234 104 4 236 104 3 267
105 1 180 105 2 190 105 3 236 105 5 240 101 4 242
;
run;


proc sort data=home.testsort out=home.testsort;
    by ID week;
run;


* lag will lag the values by 1 i.e shift the value to prior value;
* dif function will calculate the difference between value and value before it;
data home.lagdiff;
    set home.testsort;
    by ID week;
    lagg = lag(wt);
    diff = dif(wt);
    P_change = diff / lagg * 100;
    if first.ID then P_change = 0;
run;



* Ceil function returns smallest integer greater then the input argument;
* Floor function returns the largest integer than is less than or smaller then the input argument;
* Round function return the value of the first argument the nearest multiples of the;
* second argument or whole integer if second argument is missing;
data _null_;
    floorme = 123.98;
    ceilme = 289.33;
    roundme = 345.45;
    floorm = floor(floorme);
    ceilm = ceil(ceilme);
    roundm = round(roundme);
    roundm2 = round(roundme,10)
    put floorme= ceilme= roundme=;
    put floorm= ceilm= roundm=;
run;




* mdy, intck, intnx functions;
* mdy function returns the month, year, day, weekday, quarter of the date;
* intck returns the time interval between 2 datalines;
* intnx returns a future date give a time interval;
data home.anniversary(drop=yr) home.serviceyears (drop=yr);
	set sasuser.mechanics(keep=id lastname firstname hired);
	Yr= intck('year',hired, today());
	MonthEmployed = month(hired);
	YearsInService = put(yr,2.)|| " Years in Service";
	if Yr gt 20 and month(hired)=8 then output anniversary;
	output serviceyears;
	format YearsInService $35. MonthEmployed monthfmt.;
run;

proc print data=home.anniversary;
	title "More than 20-year Anniversaries in month of August";
run;
title;


proc print data=serviceyears;
	title "Employee years of service";
run;
title;



* Missing function;
* Returns 1 is value is missing or 0 is not missing;
data _null_;
    set home.health end=eof;
    array num{*} _Numeric_;
    array Str{*} _Character_;
    do i=1 to dim(num);
        if missing(num[i]) then countNum+1;
    end;
        do i=1 to dim(Str);
        if missing(Str[i]) then countStr+1;
    end;
    put countNum= countStr=;
run;



* sum function in data step and sum statement in proc print;
* sum in data step, sum the observations, row summation;
data sumf;
    set sashelp.cars;
    totalsum = sum(of invoice msrp);
run;


* sum in proc print;
* this sum the variables , column summation;
proc print data=sumf;
    sum invoice msrp;
run;



data logfac;
    a = 4;
    faca = fact(a);
    loga = log(a);
    log10a = log10(a);
    squa = sqrt(a);
run;