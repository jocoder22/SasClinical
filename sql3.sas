* This demonstrates some sql functions ;
* creating macro variable using into ;
proc sql;
    select monotonic() as Obs, name, age 
    into :name1 - :name19, :age1 - :age19
    from sashelp.class;
quit;



* using monotonic() function ;
* This issues a warning message in the log ; 
* WARNING: Statement terminated early due to OUTOBS=12 option. ;
* select the first 12 observation with outobs option ;
proc sql outobs=12;
	select * from sashelp.class;
quit;

proc sql;
	select monotonic() as Obs, * from sashelp.class;
quit;

* select the first 12 observation with monotonic function ;
* No warning message here !! ;
proc sql;
	select * 
	from sashelp.class
	where monotonic() <=  12;
quit;


* This select range of observation ;
proc sql;
	select * 
	from sashelp.class
	where monotonic() between 9 and 15;
quit;



* generate data set ;
data demo(drop = i);
	do i = 1 to 90;
		Age = int(ranuni(89) * 100);
		Age2 = ceil(ranuni(456) * 100);
		Weight = floor(ranuni(789) * 1000);
		SBP = floor(ranuni(12) * 200);
		if Age < 16 or Age > 90 then call missing(Age);
		if Age2 < 16 or Age2 > 90 then call missing(Age2);
		if Weight < 80 or Weight > 220 then call missing(Weight);
		output;
	end;
run;


* Using coalesce function ;
proc sql;
	select monotonic() as Obs, *, coalesce(Age, Age2, ceil(avg(Age))) as newAge,
		coalesce(weight, floor(avg(weight))) as newWt
	from demo;
quit;



* count, nmiss function ;

proc sql noprint; Create table mmn as
	select count(*) as N 'Total',
		count(Age) as Age 'Non-missing Age',
		nmiss(Age) as Agem 'Missing Age',
		count(Age2) as Age2 'Non-missing Age2',
		nmiss(Age2) as Age2m 'Missing Age2',
		count(Weight) as Weight 'Non-missing Weight',
		nmiss(Weight) as Weightm 'Missing Weight'
 	from demo;
quit;

* Transpose the data ;
proc transpose data=mmn 
		name=Variables 
		label=Variable_Labels 
		out=TransMMN;
	var n age agem age2 age2m weight weightm;
run;



* Create format ;
proc format;
	value sbpfmt 
		160-high = 'Severe'
		140-<160 = 'Moderate'
		120-<140 = 'Normal'
		other    = 'Low'
		;
run;


proc sql;
	select Age, weight, sbp 
	from demo
	where sbp between 80 and 180;
quit;



proc sql;
	select Age, weight, sbp format=sbpfmt.
	from demo
	where put(sbp,sbpfmt.) in ("Severe","Moderate");
quit;
