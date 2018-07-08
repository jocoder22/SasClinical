
* This show changing the obs= print options;
* with sorting;
proc sort data=sasuser.admit out=sortAdmit;
	by Age;
run;

* changing the label of obs, using obs= option;
proc print data=sortAdmit obs="Rank";
run;


* Without sorting;
proc print data=sasuser.admit (obs=10) obs="Rank";
run;




* Inserting blank lines using blankline= options;
proc print data=sashelp.cars blankline=10 label;
	var Make EngineSize Horsepower weight invoice;
	title1 "Inserting Blank line";
	title2 "At Every 1oth line";
	label invoice ="Retail Price";
	label make ="Manufacturer";
run;
