* Vbar uses freq statistics as default;
* Without discrete uses the mid-point for the values;
proc chart data=sashelp.class;
    vbar age;
run;
quit;



* With discrete option, the exact values are used;
proc chart data=sashelp.class;
    vbar age / discrete;
run;
quit;


* Using the graphical charts, gcharts;
* this is more colorful and clearer;
proc gchart data=sashelp.class;
    vbar age;
run;
quit;

* change statistics from freq to percent using type option;
proc chart data=sashelp.class;
    vbar age/ discrete type=percent;
run;
quit;


* using sumvar to get summary variable, i.e the y-axis;
* Here we find the average(mean) height for each discrete age;
* mean option displays the values on top of each bar;
proc chart data=sashelp.class;
    vbar age / discrete type=mean sumvar=height mean;
run;
quit;


* use the group option for categorical groups
* this displays chart for each group on the same graph;
proc chart data=sashelp.class;
    vbar age / discrete type=mean sumvar=height mean group=sex;
run;
quit;

* subgroup= option stack the groups on top of each other;
proc chart data=sashelp.class;
    vbar age / discrete type=mean sumvar=height mean subgroup=sex;
run;
quit;

* To get the group graphs on separate pages/output;
* use the by options, after sorting the data;
proc sort data=sashelp.class;
    sort by sex;
run;

proc chart data=sashelp.class;
    vbar age / discrete type=mean sumvar=height mean;
    by sex;
run;
quit;
