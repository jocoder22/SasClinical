libname library "C:\Users\Jose\Documents\SasClinical";
filename myformat "C:\Users\Jose\Documents\SasClinical\formats";



* Creating user defined formats;
proc format library=library;
    value $gender "F" = "Female"
                  "M" = "Male"
                  ;
    value &gen "F" = 1 "M" = 2 ;
    value agegrp  11 - 12 = "Young"
                  13 - 14 = "Middle"
                  15 - high = "Old"
                  ;
run;

options fmtsearch=(library);

proc print data=sashelp.class;
    format sex $gender. age agegrp. ;
run;