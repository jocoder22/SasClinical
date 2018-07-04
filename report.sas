proc sort data=sashelp.class out=class1;
    by sex;
run;

proc report data=class1 nowd headskip headline;
    column ('--' sex age height weight,('-- wt stats --' min n mean));
    define sex/order;
    break after sex/ skip dol dul summarize;
run;