libname sdtm "/folders/myshortcuts/Sas_Training/SDTAM";
%let ggg=/folders/myshortcuts/Sas_Training/ADaM/EG.sas;
%include "&ggg";


data adeg;
    set work.eg;
	egeval=EGEVAL;
	egcat=EGCAT;
	aval=EGSTRESN;
	avalc=EGSTRESC;
	ablfl=EGBLFL;
	param=EGTEST;
	paramcd=EGTESTCD;
	adt=EGDTC;
	atm=EGDTC;
	avisitn=VISITNUM/10;
	avisit=VISIT ;
	if EGBLFL="Y" then base=EGSTRESN;
	if EGTESTCD='INTP' then norm=EGSTRESC;
	keep &keepvar;
run;