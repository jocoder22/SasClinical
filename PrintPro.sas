
* This show changing the obs= print options;
* with sorting;
proc sort data=sasuser.admit out=sortAdmit;
	by Age;
run;

proc print data=sortAdmit obs="Rank";
run;


* Without sorting;
proc print data=sasuser.admit (obs=20) obs="Rank";
run;