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


/*
Using single trailing @, to hold the line for another input

The @ holds the line for multiple iterations within one data step.

Usally work with Output statement;

*/


data home.single;
    datalines;
    input Name$ Age Gender$ Height Weight @;
    if Gender = 'F' then do;
        input TaxR;
        Comment = "Female Taxation rule";
        Output;
    end;
    else do;
        input TaxR*1.2;
        Comment = "Male Taxation rule (x1.2)";
        Output;
    end;
    datalines;
Jones 37 M 74.8 148 2245
Mary 34 F 56.2 138 2232
Jane 45 F 67.8 122 2421
Peter 44 M 73.5 168 2355
John 39 M 70.2 161 2346
Mark 32 M 69.7 159 2156
James 45 M 66.1 163 2145
Helen 38 F 55.0 145 2034
Ann 31 F 59.1 136 2456
;
run;

proc print data=home.single;
run;


data home.census(drop=code);
    retain City State;
    input code$ @;
    if code='City' then 
        input City$ State$;
    else if code='Pol' then
        do;
            input FirstName$ LastName$ Age;
            Output;
        end;
    datalines;
City Baltimore Maryland
Pol Mark John 38
Pol James Orange 45
Pol Harley Johnson 56
City Houston Texas
Pol Pauline Barker 62
Pol Kinddy Lawson 51
run;

proc print data=home.census;
run;

