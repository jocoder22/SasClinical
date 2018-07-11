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

%printme;


%macro printed(dtname=);
    proc print data=&dtname;
    run;
%mend;

%printed(dtname=sashelp.class);


%macro sort(dset=, new=, byvar=);
    proc sort data=&dset out=&new;
        by &byvar;
    run;
%mend;

%sort(dset=sashelp.class, new=class1, byvar=age);