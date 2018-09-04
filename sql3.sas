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