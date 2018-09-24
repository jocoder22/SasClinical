option validvarname=upcase;

data patient_visits;
	input Name $ (visit1-visit4)(: mmddyy10.);
	format visit1-visit4 mmddyy10.;
	datalines;
Joe 01/05/2011 01/15/2011 01/25/2011 02/03/2011
Sam 01/07/2011 01/17/2011 01/27/2011 02/10/2011
Ron 01/09/2011 01/19/2011 01/29/2011 03/15/2011
Bob 01/11/2011 01/21/2011 01/31/2011 02/01/2011
;
run;


* Rotate the data to long form;
data long;
	set patient_visits;
	array visitt{4} visit1-visit4;
	do i=1 to dim(visitt);
		dateofvisit=visitt{i};
		output;
	end;
	format dateofvisit mmddyy10.;
	drop visit1-visit4 i ;
run;


* Rotate to wide form;
* First sort the data;
proc sort data=long out=longsorted;
	by name dateofvisit;
run;


* Then rotate wide;
data wide;
	set longsorted;
	by name;
	array visit{4};
	retain visit;
	if first.name then call missing(of visit[*],i);
	i+1;
	visit(i)=dateofvisit;
	if last.name then output;
	format visit : mmddyy10.;
	drop dateofvisit i;
run;

* print wide dataset;
proc print data=wide;
run;



data vs;
	label USUBJID = "Unique Subject Indentifier"
		  VSTESTCD = "Vitals Signs Test Short Name"
		  VISITNUM = "Visit Number"
		  VSSTRESN = "Numeric Result/Finding in Standard Units";
	input USUBJID $ VSTESTCD $ VISITNUM VSSTRESN;
	datalines;
101 SBP 1 160
101 SBP 3 140
101 SBP 5 150
101 SBP 6 180
102 SBP 1 170
102 SBP 4 190
102 SBP 6 110
102 SBP 7 150
103 SBP 1 169
103 SBP 4 188
103 SBP 5 148
103 SBP 7 159
;
run;

* print vs dataset;
proc print data=vs;
run;

* first sort the dataset;
proc sort data=vs out=vssort;
	by usubjid;
run;


* Rotate wide;
data wide2;
	set vssort;
		by usubjid;
		keep usubjid visit1-visit7;
		retain visit1-visit7;
		array sbps {7} visit1-visit7;
		
		if first.usubjid then
			do i=1 to 7;
				sbps{i} = .;
			end;
		sbps(visitnum) =  vsstresn;
		if last.usubjid;
run;


data wide3;
	set vssort;
		by usubjid;
		keep usubjid visit1-visit7;
		retain visit1-visit7;
		array visit{7};
		if first.usubjid then call missing(of visit[*]);
			visit{visitnum}=vsstresn;
		if last.usubjid;
run;



* Using do over statement;
* Do over uses index-less array  --- remove the { }, but must have element;
data nairavalue5;
	set sasuser.Y2000;
	array carray _numeric_;
	do over carray;
		carray = carray * 100;
	end;
	format crgorev1-crgorev6 dollar20.2;
run;

proc print data=nairavalue5;
run;




* Array to calculate total;
data cargo;
	set sasuser.Y2000;
	array crg{*} crgorev1-crgorev6;
	do i = 1 to dim(crg);
		Revenue = crg{i};
		Harbour = "Harbour" || put(i, z2.);
	end;
	format Revenue dollar16.2;
	drop crgorev1-crgorev6 i;
run;


* sort dataset cargo;
proc sort data=cargo out=bydate;
	by date;
run;


proc sort data=cargo out=byharbour;
	by Harbour;
run;

* generate cargo2 dataset;
data cargo2;
	set sasuser.Y2000;
	array crg{*} crgorev1-crgorev6;

	DailyRevenue = sum( of crg{*});
	TotalRevenue + DailyRevenue;
	
	format DailyRevenue TotalRevenue dollar22.2;
	drop crgorev1-crgorev6;
run;


* generate TotalRevenue by date;
data Dbydate;
	do until(last.date);
		set bydate;
		by date;
		if first.date then TotalRevenue = 0;
		TotalRevenue + Revenue;
	end;
	format TotalRevenue dollar22.2;
	drop Harbour;
run;


* Geerate TotalRevenue by Harbour;
data Dbyharbour;
	do until(last.Harbour);
		set byharbour;
		by Harbour;
		if first.Harbour then TotalRevenue = 0;
		TotalRevenue + Revenue;
	end;
	format TotalRevenue dollar22.2;
	drop date;
run;


* Generate the month and year;
data worker2;
	set sashelp.workers;
	Month = substr(put(date, monyy5.),1,3);
	Year = substr(put(date, monyy5.),4,2);
run;


* sort worker2 by month;
proc sort data=worker2 out=bymonth;
	by month;
run;

* sort worker2 by year;
proc sort data=worker2 out=byyear;
	by year;
run;

