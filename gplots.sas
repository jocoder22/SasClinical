* Non graphical plot;
proc plot data=sashelp.class;
    plot age*height;
run;
quit;

proc plot data=sashelp.class;
    plot age*height="*";
run;
quit;

