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


/* How many observation in dataset settt3 */
data settt3;
	set emply(in=inem) sal(in=insal);
	by name;
run;


/* How many observation in dataset settt4 */
data settt4;
	set emply(in=inem) sal(in=insal);
	by name;
	if inem and insal;
run;


/* Why did the program fail */
proc sort data=emply; by descending name;
proc sort data=sal; by descending name;
data mer2;
	merge emply(in=inem) sal(in=insal);
	by name;
run;


data mndt;
	dattt = mdy(03,12,2013);
run;


proc format;
    value monthfmt 1="January" 2="February" 3="March" 4="April"
                   5="May" 6="June" 7="July" 8="August"
                   9="September" 10="October" 11="November" 12="December"
                   ;
run;

data anniversary(drop=yr tmonth retire) serviceyears (drop=yr tmonth);
	set sasuser.mechanics(keep=id lastname firstname hired birth);
	Yr= intck('year',hired, today());
	retire = intnx('month',birth,65*12,'end');
	tmonth = month(today());
	MonthEmployed = month(hired);
	YearsInService = put(yr,2.)|| " Years in Service";
	Retirement = 'Retirement is on '||put(retire,date9.);
    dayto = mdy(01,23,2018);
	if Yr gt 20 and month(hired)=tmonth then output anniversary;
	output serviceyears;
	format YearsInService $35. MonthEmployed monthfmt. dayto date9.;
run;


/* What is the outcome here */
data _null_;
	set sashelp.class;
	file myfile(class3.csv);
	put Name $15. @5 Age weight Height;
run;


/* How many dataset */
data newdata;
	infile myfile(class.csv) dlm="," firstobs=2;
	input Name $ Sex $ Age Weight Height;
	file myfile(class3.csv);
	put Name $15. Sex$ Age weight Height;
run;



data substr1;
	length Name $ 8;
	Name = "john";
	put Name;
	i = length(Name);
	substr(Name,5,4) = "More";
	put Name;
run;


data new;
sample_str = "Pin Code 411014";
SUBSTR(sample_str, 4, 5) = ":";
run;

/* What's the value of totap */
/* missing operations */
data psa;
	if origp = . then origp = 100;
	put origp;
	transp = 100;
	origp = .;
	totap =  transp + origp;
	totap2 =  sum(transp,origp);
run;


/* why the retain here */
/* what is the value of price */
/* what is the value of costage */
data grand;
	set sashelp.class;
	retain grandt 0;
	grandt = sum(grandt, age);
	total + age;
	cost = "20000";
	numb = age;
	ddd = "_";
	price = 0.01 * cost;
	costage = cost||"_"||age;
	cotl = length(costage);
run;


/* the length and types of date1-date4 */
data datem;
	date1 = input('13mar2018',date9.);
	date2 = put('13mar2018'd,date9.);
	date3 = input('13/03/2018',ddmmyy10.);
	date4 = put('13mar2018'd,ddmmyy10.);
run;


/* How many observation here: */
/* what is the value of year, month and x */
data yyy;
	do year = 1 to 5;
		do month = 1 to 12;
			x + 1;
		end;
	end;
run;


/* How many observation here: */
data yyy2;
	do year = 1 to 5;
		do month = 1 to 12;
			x + 1;
			output;
		end;
	end;
run;



/* what is the value of n */
data nnn;
	do while(n gt 6);
		n + 1;
	end;
run;


/* what is the value of n */
data nnn;
	do while(n lt 6);
		n + 1;
	end;
run;

data doy;
	set sashelp.class;
run;


/* How many variable and observations here */
data doyear;
	do year = 1 to 3;
		set sashelp.class;
		capital + 5000;
	end;
run;


/* How many variable and observations here */
data doyear2;
	do year = 1 to 3;
		set sashelp.class(obs=3);
		capital + 5000;
	end;
run;

/* How many variable and observations here */
data doyear3;
	do year = 1 to 3;
		set sashelp.class(obs=3);
		capital + 5000;
		output;
	end;
run;

/* How many variable and observations here */
data doyear4;
	do year = 1 to 3;
		set sashelp.class;
		capital + 5000;
		output;
	end;
run;

data fil33;
	infile datalines;
	input name$ 1-4  @;
	if name = "Sue" then input age 7-8;
	else input indum 10-11;
	datalines;
Ruth  39 11
Jose  32 22
Sue   30 33
John  40 44
;
run;
