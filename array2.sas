

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



* Generate TotalRevenue by month;
data Dbymonth;
	do until(last.date);
		set bymonth(end=eof);
		by month;
		if first.date then TotalRevenue = 0;
		TotalRevenue + electric + masonry;
	end;
	GrandTotal + TotalRevenue;
    if eof then output;
run;


