options validvarname=upcase;

libname sdtm "/folders/myshortcuts/Sas_Training/SDTAM";
%let ggg=/folders/myshortcuts/Sas_Training/ADaM/EG.sas;
%include "&ggg";



%let keepvar2=studyid usubjid egeval egcat aval avalc ablfl param paramcd
		adt atm avisitn avisit base norm EGSTRESN;

        
data adeg_1;
    attrib studyid  label='Study Identifier'
		usubjid  label='Unique Study Identifier'
		egeval  label='Evaluator'
		egcat  label='Category for ECG'
		aval  label='Numeric Result in Standard Format'
		avalc  label='Character Result in Standard Format'
		ablfl  label='Baseline Flag'
		param  label='Parameter Description'
		paramcd  label='Parameter Code'
		adt  label='Actual Date of ECG Taken'
		atm  label='Actual Time of ECG Taken'
		avisitn  label='Analysis Visit number'
		avisit  label='Analysis Visit '
		base  label='Baseline Value'
		chg  label='Change from Baseline Value'
		pchg  label='Percentage Change from Baseline Value'
		norm  label='Abnormality'
	;
    set work.eg;
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
	keep &keepvar2;
run;


proc sort data=adeg_1 out=adeg_2;
  by usubjid param avisitn;
run;


data adeg;
	set adeg_2;
	retain dummy;
	by usubjid param avisitn;
	if first.usubjid then dummy=base;
	if not first.usubjid and EGSTRESN ne . then do;
		if base ne . then dummy=base;
		else base=dummy;
		chg=EGSTRESN-BASE;
		pchg=100*(EGSTRESN-BASE)/BASE;
	end;
	drop=EGSTRESN;
run;


proc print data=adeg;
run;