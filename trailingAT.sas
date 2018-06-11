/*
Using @@ to read multiple records per line.

The @@ holds the line for further iterations of the data step.

*/ 

libname home "C:\Users\Jose\Documents\SasClinical";

data home.double;
    infile datalines;
    input Subid$ Studyid$ Age Gender$ @@;
    datalines;
A20sub Inv2008 38 M A21sub Inv2008 46 F A23sub Inv2008 37 F
A22sub Inv2008 39 F A25sub Inv2008 56 M A24sub Inv2008 66 F
A26sub Inv2008 44 M A30sub Inv2008 51 M A28sub Inv2008 56 F
A27sub Inv2008 67 F A29sub Inv2008 70 M A44sub Inv2008 73 F
A34sub Inv2008 45 M A31sub Inv2008 50 F A32sub Inv2008 48 M
A33sub Inv2008 37 F A36sub Inv2008 46 M A35sub Inv2008 77 F
A45sub Inv2008 65 F A38sub Inv2008 39 M A37sub Inv2008 61 M
A40sub Inv2008 76 F A39sub Inv2008 43 M A42sub Inv2008 58 F
; 
run;

proc print data=home.double;
run;




