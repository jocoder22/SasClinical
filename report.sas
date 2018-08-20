libname myfile "C:\Users\Jose\Documents\SasClinical\sql2";


* simple proc report is same as proc print without obs;
proc report data=sashelp.class;
run;



proc sort data=sashelp.class out=class1;
    by sex;
run;

proc format;
	value $gender "F"="Female" "M"="Male";
run;

* Using proc report;
* group and order options gives the same result;
* across options create dummy variable for categorical variable;
* noprint options removes the variable from the report;
proc report data=class1 nowd headskip headline split="*";
    column ('--'  name sex age height weight,('-- wt stats --' min n mean) BMI comment;
    define name/'Employee*Name' ;
    define age/spacing=4;
    define sex/'Gender' width=7 format=$gender.;
    define BMI /computed format=6.2;
        compute BMI;
            BMI = _c5_ /(_c4_ * 0.0254)**2;
        endcomp;
    define comment/computed length=14;
		if BMI lt 18.50 then
			comment="Underweight";
		else if BMI ge 18.50 and BMI le 24.99 then
			comment="Normal weight";
		else if BMI ge 25.00 and BMI le 29.99 then
			comment="Overweight";
		else if BMI ge 30.00 then
			comment="Obese";
    endcomp;
    compute before _page_;
        line @10 'Ages, Weight and Heights of students';
        line @20 'Class 2018';
    endcomp;
    compute after;
        line ' ';
        line @2 85*'-';
        line @5 'Note: Weight in Kg';
        line @5 'Note: Heights in Inches';
    endcomp;
    compute after _page_;
        line @10 50*'-' 'PAGE END' 50*'-';
    endcomp;
    format _numeric_ 6.2;
run;



* Create another report ;
options nodate nocenter nonumber; title;
proc sql;
	create table analysis3 as select r.CTR1N, r.SBJ1N, age_1n, racen, region , 
		gender, AEVEND1O , AEVSER1C , AEVSEV1C , AEVSMR1C , AEVSTT1O , PT_TXT , 
		SOC_TXT from myfile.dm as l right join myfile.aev as r on l.sbj1n=r.sbj1n and 
		l.CTR1N=r.CTR1N order by ctr1n , sbj1n;
quit;