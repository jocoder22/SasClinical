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
proc gchart data=sashelp.class;
    vbar age/ discrete type=percent;
run;
quit;


* using sumvar to get summary variable, i.e the y-axis;
* Here we find the average(mean) height for each discrete age;
* mean option displays the values on top of each bar;
proc gchart data=sashelp.class;
    vbar age / discrete type=mean sumvar=height mean;
run;
quit;


* use the group option for categorical groups
* this displays chart for each group on the same graph;
proc gchart data=sashelp.class;
    vbar age / discrete type=mean sumvar=height mean group=sex;
run;
quit;

* subgroup= option stack the groups on top of each other;
proc gchart data=sashelp.class;
    vbar age / discrete type=mean sumvar=height mean subgroup=sex;
run;
quit;

* To get the group graphs on separate pages/output;
* use the by statement, after sorting the data;
proc sort data=sashelp.class;
    sort by sex;
run;

proc gchart data=sashelp.class;
    vbar age / discrete type=mean sumvar=height mean;
    by sex;
run;
quit;


* Subsetting the data using where statement;
proc gchart data=sashelp.class;
    vbar age / discrete type=mean sumvar=height mean;
    where sex="M" and age in (11 14 15);
run;
quit;


* using 3D graphs, vbar3d;
proc gchart data=sashelp.class;
    vbar3d age / discrete type=mean sumvar=height mean;
    where sex="M";
run;
quit;

* other 3D options like shapes= cylinder, prism, star, block, hexagon;
* patternid to change the color and width to change the width of the 3D shapes;
proc gchart data=sashelp.class;
    vbar3d age / discrete type=mean sumvar=height mean shape=cylinder width=20 patternid=midpoint;
    where sex="M";
run;
quit;


* Hbars;
* Hbars will give default freq statistics in addition to the graph;
proc gchart data=sashelp.class;
    hbar age / discrete;
    where sex="M";
run;
quit;


* Pie charts;
proc gchart data=sashelp.class;
    pie age / discrete type=mean sumvar=height mean;
    where sex="M";
run;
quit;

proc gchart data=sashelp.class;
    pie3d age / discrete type=mean sumvar=height mean;
    where sex="M";
run;
quit;


* values inside keep the values(mean) inside the pie;
* slice inside keeps the variables inside the pie;
proc gchart data=sashelp.class;
    pie3d age / discrete type=mean sumvar=height mean values=inside slice=inside;
    where sex="M";
run;
quit;





