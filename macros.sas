libname home "C:\Users\Jose\Documents\SasClinical";
filename myfile2 "C:\Users\Jose\Documents\SasClinical\macros";

%let a=sashelp.class;

proc print data=&a;
run;

data class1;
    set &a;
run;

%put &a; * print to log;

%let a=1;
%let b=2;
%let c=3.5;
%let d=8.3;


%put &a+&b;
%put %eval(&a+&b); * eval() convert values to  their integer value, works on integers only;
%put %sysevalf(&c+&d); * syseval() works on floating numbers;



* Creating macros;
%macro printme;
    proc print data=sashelp.class;
    run;
%mend;