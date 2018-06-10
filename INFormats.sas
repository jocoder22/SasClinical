
libname home "C:\Users\Jose\Documents\SasClinical";
Filename timeq2 "C:\Users\Jose\Documents\SasClinical\chapter1";  

proc format;
   picture fmtindr low-high ='000,000,000.00'
               (prefix='Rs. ' mult=100);

   picture fmtngn low-high ='000,000,000.00'
               (prefix='=N=' mult=100);

   picture fmtzabw 
   		low-high ='000,000,000.00'
               (prefix='ZBW' mult=100);

run;


data DateNew;
	infile timeq2(ex1.txt) dlm='09'X;
	input FlightNo$ Dest$ Date RevFClass RevEClass TotalRevF :$13. TotalRevE :$13. Time;
	informat Date mmddyy10. Time time8. ;
	Format Date date9. Time time8.;
Run;