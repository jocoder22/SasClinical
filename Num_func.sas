* using lag and diff function;
* lag function returns the value of previous variable;
* diff function returns the diff between current and previous value of variable;
libname home2 "C:\Users\Jose\Documents\SasClinical\chapter2"; 

proc format;
    value monthfmt 1="January" 2="February" 3="March" 4="April"
                   5="May" 6="June" 7="July" 8="August"
                   9="September" 10="October" 11="November" 12="December"
                   ;
run;

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
* The date need format to print out well, except it will print as number;
* Remember sas dates are stored as number of days from 1 Jan 1960;
data home.anniversary(drop=yr tmonth) home.serviceyears (drop=yr tmonth);
	set sasuser.mechanics(keep=id lastname firstname hired birth);
	Yr= intck('year',hired, today());
    retire = intnx('month',birth, 65*12,"end");
    tmonth = month(today());
	MonthEmployed = month(hired);
	YearsInService = put(yr,2.)|| " Years in Service";
    Retirement = 'Retirement is on '||put(retire,date9.);
    dayto = mdy(01,23,2018);
	if Yr gt 20 and month(hired)=tmonth then output anniversary;
	output serviceyears;
	format YearsInService $35. MonthEmployed monthfmt. dayto date9.;
run;



proc print data=home.anniversary;
	title "More than 20-year Anniversaries in month of August";
run;
title;


proc print data=serviceyears;
	title "Employee years of service";
run;
title;




* Using time  and related functions;
data timme;
    tm = time();
    date2 = '09jul2018'd;
    time1 = hms(05,12,18);
    time2 = '14:56:51't;
    dtime = datetime();
    dtime2 = dhms(date2,19,32,14);
    format tm time1 time2 time8. dtime dtime2 datetime18.;
run;


* using yrdiff, timepart, datepart function;
data parttd;
    input dt : datetime18.;
    format dt datetime18.;
    birthd = '09jun1989'd;
    todayd = today();
    ageyr = round(yrdiff(todayd, birthd, 'actual'));
    datame = '09mar2018:18:38:45'dt;
    dpart = datepart(datame);
    tpart =  timepart(datame);
    datalines;
    12jun2008:14:09:59
    ;
run;


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



* factorial, square root, log and log10 functions;
data logfac;
    a = 4;
    faca = fact(a);
    loga = log(a);
    log10a = log10(a);
    squa = sqrt(a);
run;




* Input and put functions;
* Remember date is a non-standard numeric variable;
* so length of date is always 8;
data putinp;
    input jdate: ddmmyy10,;
    format jdate ddmmyy10.;
    datalines;
    17/01/2018
    ;
    run;


* put functions, the length of the resulting variable is same as the format width;
* using input function, the length of the resulting numeric variable will be 8;
* for input function, if not using format for resulting variable, defaults for best12.   ;
data newputin;
    set putinp;
    char = put(jdate, ddmmyy10.);
    char2 = put(jdate, date9.);
    num = input(char, ddmmyy10.);
run;




sas9 -locale pl_PL;
      libname new "C:\Users\Jose\Documents\SASAql" ;
      filename trans "C:\Users\Jose\Downloads\ZIPPROCSQL\sql.cpo";

      proc cimport isfileutf8=no library=new infile=trans;
      run;

proc options option=encoding;    
run;