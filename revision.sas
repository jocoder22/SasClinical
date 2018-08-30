libname clinic "C:Documents/SasClinical";
filename myfile "C:Documents/SasClinical";

data mm;
	set sashelp.class;
run;

proc sort data=mm; by sex; run;

/* What is the result here */
data clinic.mm2;
	merge clinic.mm2 work.mm;
	by sex;
run;


data hhh;
	do until(prod gt 6);
		prod + 1;
	end;
run;


data class1;
	infile myfile('class.csv') dlm="," firstobs=2;
	input Name$ Sex$ Age Height Weight;
run;

data _NULL_;
	set sashelp.class;
	file myfile('class2.csv') dlm=",";
	if _N_ = 1 then
	put 'Name,Sex,Age,Height,Weight';
	put Name Sex Age Height Weight;
run;


data _null_;
   set sasuser.finance;
   file myfile('finance.csv') dlm=",";
   put 'Social Security Number '  SSN  Name
      ' totaled ' salary : dollar9. Date date9.;
run;


ods csvall file='C:Documents/SasClinical/class3.csv';
	proc print data=sashelp.class noobs;
	run;
ods csvall close;


data emply;
	infile datalines;
	input name$ age;
	datalines;
bruce 30
dan 35
dan .
;
run;



data Sal;
	infile datalines;
	input name$ salary;
	datalines;
bruce 40000
bruce 35000
dan 37000
dan 68000
;
run;


proc sort data=emply; by name;run;
proc sort data=sal; by name;run;


/* How many dataset */
/* How many observation in dataset mer */
data mer;
	merge emply(in=inem) sal(in=insal);
	by name;
	if inem and insal;
run;


/* How many observation in dataset settt2 */
data settt2;
	set emply(in=inem) sal(in=insal);
	by name;
run;

