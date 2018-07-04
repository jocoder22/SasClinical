proc sort data=sashelp.class out=class1;
    by sex;
run;

proc report data=class1 nowd headskip headline;
    column ('--' sex age height weight,('-- wt stats --' min n mean));
    define sex/order;
    break after sex/ skip dol dul summarize;
    compute before _page_;
        line @10 'Ages, weight and Heights of student';
        line @20 'Class 2018';
    endcomp;
    compute after _page_;
        line @5 'Note: Weight in Kg';
        line @5 'Note: Heights in Inches';
    endcomp;
run;