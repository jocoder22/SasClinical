proc sort data=sashelp.class out=class1;
    by sex;
run;


* Using proc report;
* group and order options gives the same result;
* across options create dummy variable for categorical variable;
proc report data=class1 nowd headskip headline;
    column ('--'  name sex age height weight,('-- wt stats --' min n mean));
    define name/'';
    define age/spacing=4;
    define sex/'Gender' order width=7 across;
    break after sex/ skip dol dul summarize;
    compute before _page_;
        line @10 'Ages, weight and Heights of student';
        line @20 'Class 2018';
    endcomp;
    compute after _page_;
        line @5 'Note: Weight in Kg';
        line @5 'Note: Heights in Inches';
    endcomp;
    format _numeric_ 6.2;
run;