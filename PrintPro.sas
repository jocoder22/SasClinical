
* This show changing the obs= print options;

proc sort data=sasuser.admit out=sortAdmit;
	by Age;
run;

proc print data=sortAdmit obs="Rank";
run;