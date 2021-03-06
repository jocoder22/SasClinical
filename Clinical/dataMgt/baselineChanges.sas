option validvarname=upcase;

* This calculate change from baseline and percentage change from baseline;
data VS;
	label USUBJID = "Unique Subject Indentifier"
		  VSTESTCD = "Vitals Signs Test Short Name"
		  VISITNUM = "Visit Number"
		  VSSTRESN = "Numeric Result/Finding in Standard Units";
	input USUBJID $ VSTESTCD $ VISITNUM VSSTRESN @@;
	datalines;
101 SBP 0 160 101 DBP 0 60
101 SBP 1 140 101 DBP 1 80
101 SBP 2 150 101 DBP 2 90
101 SBP 3 180 101 DBP 3 100
101 SBP 4 180 101 DBP 4 66
101 SBP 5 180 101 DBP 4 99
102 SBP 0 160 102 DBP 0 70
102 SBP 1 170 102 DBP 1 80
102 SBP 2 190 102 DBP 2 90
102 SBP 3 110 102 DBP 3 79
102 SBP 4 150 102 DBP 4 72
102 SBP 5 150 102 DBP 5 98
103 SBP 0 161 103 DBP 0 69
103 SBP 1 169 103 DBP 1 95
103 SBP 2 188 103 DBP 2 99
103 SBP 3 148 103 DBP 3 78
103 SBP 4 159 103 DBP 4 97
103 SBP 5 159 103 DBP 5 101
;
run;

proc sort data=vs out=vssorted;
	by USUBJID VSTESTCD  VISITNUM;
run;
    

data advs;		  
	set vssorted;
        by USUBJID VSTESTCD  VISITNUM;

    Label AVAL = "Analysis Value"
        PARAMCD = "Parameter Code"
        AVISITN = "Analysis Visit(N)"
        ABLFL = "Baseline Record Flag"
        BASELINE = "Baseline Value"
        CHG = "Change from Baseline"
        PCHG = "Percentage Change from Baseline";
	
	aval = vsstresn;
	paramcd = vstestcd;
	avisitn = visitnum;
	
	retain baseline;
	
	if first.vstestcd then 
		do;
			ablfl="Y";
			baseline = aval;
		end;
	else do;
		change = aval - baseline;
		pchg = ((aval - baseline) / baseline) * 100;
	end;
run;


proc print data=advs;
	var usubjid aval baseline change pchg;
run;