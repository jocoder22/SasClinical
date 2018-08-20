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
		SOC_TXT from myfile.dm as l left join myfile.aev as r on l.sbj1n=r.sbj1n and 
		l.CTR1N=r.CTR1N order by ctr1n , sbj1n;
quit;




data finalanaly;
	set analysis3b end=eof;
	centre="02"||put(ctr1n, z2.);
	rcp=put(region, region.)||"/"||centre||"/"||put(sbj1n, z5.);
	asr=put(age_1n, 2.)||"/"||put(gender, sex.)||"/"||put(racen, race.);
	aps=strip(AEVNAM1A)||'/'||strip(PT_TXT)||"/"||strip(SOC_TXT);
	aestdtc=substr(AEVSTT1O, 1, 9);
	aeendtc=substr(AEVEND1O, 1, 9);

	if AEVSEV1C=. then
		AEVSEV1C=0;

	if AEVSEV1C=0 and AEVSMR1C=. then
		AEVSMR1C=2;

	if aestdtc=' ' then
		aestdtc='01JAN2010';

	if aeendtc=' ' then
		aeendtc='01JAN2011';
	aesteddtc=strip(aestdtc)||"/"||strip(aeendtc);

	if eof then
		lastrec=1;
	keep &keepvar;
	format SBJ1N z5. region region. gender sex. racen race. AEVSEV1C sev. AEVSMR1C 
		rel.;
run;
