* Vbar uses freq statistics as default;
* Without discrete uses the mid-point for the values;
proc chart data=sashelp.class;
    vbar age;
quit;
run;


* With discrete option, the exact values are used;
proc chart data=sashelp.class;
    vbar age / discrete;
quit;
run;


* Using the graphical charts, gcharts;
* this is more colorful and clearer;
proc gchart data=sashelp.class;
    vbar age;
quit;
run;

* change statistics from freq to percent using type option;
proc chart data=sashelp.class;
    vbar age/ discrete type=percent;
quit;
run;


* using sumvar to get summary statistics, i.e the y-axis;
* Here we find the average(mean) height for each discrete age;
proc chart data=sashelp.class;
    vbar age / discrete type=mean sumvar=height;
quit;
run;