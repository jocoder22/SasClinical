options nodate nonumber;

proc tabulate data=sasuser.empdata order=freq format=comma10.;
    class hiredate;
    var salary;
    table hiredate, salary*(n (sum mean)*f=dollar10.2);
    format hiredate monname.;
    label hiredate="Month Hired";
    title "Total Salary for Staff by Hire Month";
run;



proc tabulate data=sashelp.cars;
	class make drivetrain origin;
	var invoice;
	table origin="", drivetrain="Drive Train"*invoice=""*
            (min="Lowest Price" mean="Average Price")*format=dollar12.2/ rts=23 ;
	title;
run;



proc tabulate data=sashelp.cars;
	class drivetrain origin cylinders;
	var invoice;
	table origin*cylinders, drivetrain="Drive Train"*invoice=""*mean=""*format=dollar12.2/ rts=25 ;
	title;
run;



proc tabulate data=sashelp.class;
	class sex;
	var age;
	table sex age;
run;


proc tabulate data=sasuser.blood;
	class gender bloodgrp;
	var rbc;
	table gender rbc bloodgrp;
run;


* Cross tabulation;
* using * , gives flat orientation ;
proc tabulate data=sasuser.blood;
	class gender bloodgrp;
	var rbc;
	table gender*bloodgrp;
run;


* using comma (,) give tabular orientation with rows and columns;
* The row before comma and columns after comma ;
proc tabulate data=sasuser.blood;
	class gender bloodgrp;
	var rbc;
	table gender, bloodgrp;
run;


* Adding format to manage variable length ;
proc tabulate data=sasuser.blood;
	class gender bloodgrp;
	var rbc;
	table gender, bloodgrp (rbc chole)*(mean*f=7.2 n*f=3.);
run;


* multiple cross multiplication ;
* Here gender and bloodgrp forms the row while rbc and chole the columns;
proc tabulate data=sasuser.blood;
	class gender bloodgrp;
	var rbc;
	table gender*bloodgrp, (rbc chole)*(mean*f=7.2 n*f=5.2);
run;


* label variables using keylabel ;
proc tabulate data=sasuser.blood;
	class gender bloodgrp;
	var rbc;
	table gender all*bloodgrp all, (rbc chole)*(mean*f=7.2 n*f=5.2);
	keylabel mean="Average" all="Total";
run;


* Handle box with rts= and box= ;
* rts to size the length of the box, while box= to insert label or text ;
proc tabulate data=sasuser.blood;
	class gender bloodgrp;
	var rbc;
	table gender*bloodgrp, (rbc chole)*(mean*f=7.2 n*f=5.2) / rts=30 box="Insert text here";
run;

