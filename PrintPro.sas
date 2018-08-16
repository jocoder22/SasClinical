libname home "C:\Users\Jose\Documents\SasClinical\sql2";
filename myfolder "C:\Users\Jose\Documents\SasClinical";

* print options -- noobs width double heading lable split n  ;
* print statements -- id var label by ;
* width can by full or minimium, uniform uniformby (default);
* double give double spacing blw observations;
proc print data=sashelp.class noobs width=full double;
	var age sex weight;
run;



* heading displays the variable name in a particular orientation -- horizontal or veritcal;
* n print the number of observations at the end of the report;
proc print data=sashelp.class noobs heading=veritcal  n;
	var age sex weight;
run;





* This show changing the obs= print options;
* with sorting;
proc sort data=sasuser.admit out=sortAdmit;
	by Age;
run;

* Without sorting;
proc print data=sasuser.admit (obs=10) obs="Rank";
run;

* changing the label of obs, using obs= option;
proc print data=sortAdmit obs="Rank";
run;



* creating sequence number;
proc sort data=sashelp.class out=class;
	by sex;
run;

* Create sequence number for each by group;
data classsqe;
	set class;
	by sex;
	if first.sex then seqNo = 1;
	else seqNo + 1;
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