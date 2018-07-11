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



* keyword parameters;
%macro sort(dset=, new=, byvar=);
    proc sort data=&dset out=&new;
        by &byvar;
    run;
%mend;

%sort(dset=sashelp.class, new=class1, byvar=age);



* Positional parameters;
%macro sorted(dset1, new1, byvar1);
    proc sort data=&dset1 out=&new1;
        by &byvar1;
    run;
%mend;

%sorted(sashelp.class, class2, sex);


%macro multi(cond=, old=, new=, byvar=, tvar=; avar=);
    %if &cond=S %then %do;
        proc sort data=&old out=&new;
            by &byvar;
        run;
    %end;
    %if &cond=F %then %do;
        proc freq data=&new;
            by &byvar;
            table &tvar;
        run;
    %end;
    %if &cond=M %then %do;
        proc means data=&new;
            by &byvar;
            var &avar;
        run;
    %end;
    %if &cond=P %then %do;
        proc print data=&new;
        run;
    %end;
%mend;


%multi(cond=S, old=sashelp.class, new=class4, byvar=sex);
%multi(cond=S, old=sasuser.blood, new=blood, byvar=gender); 
%multi(cond=F, new=class4, byvar=sex, tvar=age);  
%multi(cond=M, new=blood, byvar=gender, avar=rbc);