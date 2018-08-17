* simple proc report is same as proc print without obs;
proc report data=sashelp.class;
run;



proc sort data=sashelp.class out=class1;
    by sex;
run;


* Using proc report;
* group and order options gives the same result;
* across options create dummy variable for categorical variable;
* noprint options removes the variable from the report;
proc report data=class1 nowd headskip headline;
    column ('--'  name sex age height weight,('-- wt stats --' min n mean) BMI);
    define name/'';
    define age/spacing=4;
    define sex/'Gender' order width=7 across;
    break after sex/ skip dol dul summarize;
    define BMI /coomputed format=6.2;
        compute BMI;
            BMI = _c4_ /(_c5_ * 0.0254)**2;
        endcomp;
    define comment/coomputed;
        compute comment/ character;
            comment = 'Good';
        endcomp;

    compute after sex;
        comment = 'Total';
        if sex="F" then sex="Female";
        else if sex="M" then sex="Male";
    endcomp;
    compute before _page_;
        line @10 'Ages, Weight and Heights of students';
        line @20 'Class 2018';
    endcomp;
    compute before ;
        line @10 'REPORT STARTS HERE!';
    endcomp;
    compute after;
        line @5 'Note: Weight in Kg';
        line @5 'Note: Heights in Inches';
    endcomp;
    compute after _page_;
        line @10 "--"*(50)'PAGE END' "--"*(50);
    endcomp;
    format _numeric_ 6.2;
run;