* Non graphical plot;
proc plot data=sashelp.class;
    plot age*height;
run;
quit;

proc plot data=sashelp.class;
    plot age*height="*";
run;
quit;

* Graphical plots;
proc gplot data=sashelp.class;
    plot age*height;
run;
quit;


* Different groups on the same graph;
proc gplot data=sashelp.class;
    plot age*height=sex;
run;
quit;


* Add custom colors and symbols;
symbol1 color=green value=circle height=2;
symbol2 color=red value=star height=2;

proc gplot data=sashelp.class;
    plot age*height=sex;
run;
quit;


* Advanced plots using sgplots;
* the HTML output is the default ODS;
* scatter, series, step and box plots;
proc sgplot data=sashelp.class;
    scatter x=height y=weight;
run;
quit;


* change marker attributes;
proc sgplot data=sashelp.class;
    scatter x=height y=weight/ markerattrs=(symbol=star size=6);
run;
quit;


* Use series sgplot to produce joined points;
proc sgplot data=sashelp.class;
    series x=height y=weight;
run;
quit;