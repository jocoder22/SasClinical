
libname home "C:\Users\Jose\Documents\SasClinical";
Filename timeq2 "C:\Users\Jose\Documents\SasClinical\chapter1";  

/* Create formats to write currencies for India, Nigeria and Zimbabwe*/
proc format library=home;
   picture fmtindr low-high ='000,000,000.00'
               (prefix='Rs. ' mult=100);

   picture fmtngn low-high ='000,000,000.00'
               (prefix='=N=' mult=100);

   picture fmtzabw 
   		low-high ='000,000,000.00'
               (prefix='ZBW' mult=100);

run;

proc format library=home fmtlib;
run;

options fmtsearch=(home); * reference to the library


data home.DateNew;
	infile timeq2(ex1.txt) dlm='09'X;
	input FlightNo$ Dest$ TravelDate RevFClass RevEClass TotalRevF :$13. TotalRevE :$13. TravelTime;
	informat TravelDate mmddyy10. TravelTime time8. ;
	Format TravelDate date9. TravelTime time8.;
Run;


proc print data=home.DateNew;
run;

/*  This section will use National Language Support (NLS)
    for Britian, India and United Arab Emirate */
data home.Currency;
	infile datalines;
	input Amount1-Amount3;
	format Amount1 nlmnigbp16.2 Amount2 nlmnlinr14.2 Amount3 NLMNIAED16.2;
	datalines;
18384 494394 493493
32432 983438 5918573
58384 4458454 525454
4728454 48545 5488545
52954 745052 8494845
2040540 25440 954902
;
run;

proc print data=home.Currency;
run;


/* Write out the file using dsd -  double quotes and comma delimiter*/
data _null_;
	 set home.Currency;
	 file timeq2(Revenue.txt) dsd;
	 put Amount1-Amount3;
	 format Amount1 nlmnigbp16.2 Amount2 nlmnlinr14.2 Amount3 NLMNIAED16.2;
run;



* Write out the file using dlm= " ";
data _null_;
	 set home.Currency;
	 file timeq2(Revenue2.txt) dlm=" ";
	 put Amount1 :nlmnigbp14. Amount2 :nlmnlinr14. Amount3 :NLMNIAED18.;
run;


data home.Currency2;
	infile timeq2(Revenue2.txt);
	input Month1 :nlmnigbp14. Month2 :nlmnlinr14. Month3 :NLMNIAED18.;
run;

proc print data=home.Currency2;
	format Month1 :nlmnigbp14. Month2 :nlmnlinr14. Month3 :NLMNIAED18.;
run;

/* Apply user defined formats */
proc print data=home.Currency2;
	format Month1 :fmtzabw14. Month2 :fmtindr16. Month3 :fmtngn14.;
run;