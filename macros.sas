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

* macro with keyword parameter;
* the named keyword automatically becomes a macro variable;
%macro printed(dtname=);
    proc print data=&dtname;
    run;
%mend;

%printed(dtname=sashelp.class);

%macro dtcreat(new=, old=, var=, val=);
    data &new;
        set &old;
        where &var=&val;
    run;
%mend;

* keyword parameters;
%macro sort(dset=, new=, byvar=);
    proc sort data=&dset out=&new;
        by &byvar;
    run;
%mend;

%sort(dset=sashelp.class, new=class1, byvar=age);



* Positional parameters;
* the positional parameter must be listed according to their positions;
%macro sorted(dset1, new1, byvar1);
    proc sort data=&dset1 out=&new1;
        by &byvar1;
    run;
%mend;

%sorted(sashelp.class, class2, sex);


* Using keyword parameter is the standard;
* the parameters can be listed in any order;
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


%macro looped(dtname=);
%let i=1;
%do %while (&i le 4);
    %let dset=%scan(&dtname, &i);
        proc print data=&dset;
        run;
        %let i=%eval(&i+1);
    %end;
%mend;


%looped(dtname=sashelp.class sasuser.blood sashelp.cars sashelp.housing);


* Macro interface functions;
* uses data set functions in macro programs;
%let a = "This is sas";
%let b = "This is_sas";
%put %length(&a);
%put %scan(&a, 1);

%put %sysfunc(countw(&a));
%put %sysfunc(scan(&b, 1, %str(_)));
* Using sql to create macros;
proc sql;
    select name into: mvar separated by ','
    from sashelp.class;
quit;

%put &mvar;


proc sql noprint;
    select name into: mvar1 - :mvar19 
    from sashelp.class;
quit;
%put &mvar1;
%put &mvar7;
%put &mvar12;
%put &mvar17;



* Debugging options;
* macro debubbing options are global options;
* mprint will print the procedures inside the macro;
* noprint deactivates the mprint options;
options mprint;
%printme;
%printed(dtname=sashelp.class);


* serror and merror options are the default;
* serror give warning for non-existing macro variable;
* merror gives warning for non-existing macro catalog or function;
* the noserror and nomerror options deactivates them;

options serror merror;
%put &pander; * serror will give warning message;
%donnett; * merror will give warning message;

* mlogic symbolgen gives different message but same meaning ;
* the two explains what is happend behide the hoard;
* mlogic has Beginning execution and Ending execution messages;
options mlogic symbolgen;
%printed(dtname=sashelp.class);


* Storing and saving macros;
* options sasmstore= links the the folder, and mstored is the save command;
libname mstorage "C:\Users\Jose\Documents\SasClinical\macros\mstore";
options sasmstore=mstorage mstored;

%macro printtf/ store source;
    proc print data=sashelp.class;
    run;
%mend;


* Using saved macros;
* the sasautos options will run the library where the macro is stored;
libname run "C:\Users\Jose\Documents\SasClinical\macros\mstore";
options sasautos = mstorage;
%printtf;


* Autocall macros: use to execute programs save in another file;
* using %include ;
%include "C:\Users\Jose\Documents\SasClinical\macros";
%include "C:\Users\Jose\Documents\SasClinical\macros\logg.txt";


filename mydoc "C:\Users\Jose\Documents\SasClinical\macros";
%include mydoc;


* System defined automatic macro variables;
%put _automatic_;
%put &sysdate;
%put &sysver;
%put &syslast;
%put &sysvlong;
%put &sysuserid;


* Multiply &;
%let dsn=abc;
%let i = 1;
%let dsn1=abc1;
%let abc1=cba1;

%put &dsn&i; * ==> abc1 ;
%put &&dsn&i; * ==> abc1 ;  * && resolves to &;

%put &&&dsn&i; * ==> cba1 ;
* first leftmost && resolves to &, then &dsn1  ==> abc, and &i ==> 1;
* now we have &abc1 ==> cba1 ;


