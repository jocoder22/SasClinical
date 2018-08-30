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

