

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



* Using sashelp.worker2 dataset;
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



* Generate TotalRevenue by month;
data Dbymonth;
	do until(last.date);
		set bymonth end=eof;
		by month;
		if first.date then TotalRevenue = 0;
		TotalRevenue + electric + masonry;
	end;
	GrandTotal + TotalRevenue;
    if eof then output;
run;



* Customized sort using proc sql;
proc sql;
	create table bymonth2 as
	select * ,
        case (month)
             When  "JAN" then 1
             When "FEB" then 2
             When  "MAR" then 3
             When  "APR" then 4
             When  "MAY" then 5
             When  "JUN" then 6
             When  "JUL" then 7
             When  "AUG" then 8
             When  "SEP" then 9
             When  "OCT" then 10
             When  "NOV" then 11
             When  "DEC" then 12
             else .
        end as monthcase
        from worker2
       order by monthcase;
quit;

data Dbymonth2;
	do until(last.monthcase);
		set bymonth2 end=eof;
		by monthcase;
		if first.monthcase then TotalRevenue = 0;
		TotalRevenue + electric + masonry;
	end;
	GrandTotal + TotalRevenue;
	format month $mnthv.;
	drop monthcase year;
run;
