libname home "C:\Users\Jose\Documents\SasClinical\sql2";
filename myfolder "C:\Users\Jose\Documents\SasClinical"
;
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


* Using proc printto;
* This prints the results to external file;
* The first proc printto opens the connection;
proc printto print='myfolder\printto1.txt'
	log='myfolder\printto_log.txt';
run;


* print the result of proc print;
proc print data=sashelp.admit;
run;


* print the result of proc sql;
* the proc sql select statement is used for printing;
proc sql;
	select make origin type invoice
	from sashelp.cars;
quit;
* Last proc printto closes the connection;
* without closing, the print output/results are printed to the same file;
proc printto;
run;