option validvarname=upcase;

option validvarname=upcase;

data vv(drop=num);
	length visit $10. subjid $3.;
	do subjid="101" ,"102";
		visnum = 0;
		visit="Screening";
		output;
		do num=2 to 14 by 2;
			visnum=num;
			visit="Week "||put(num,2.);
			output;
		end;
	end;
run;



data vv2;
	input subjid $3. visit $10. value stdy;
	if visit="Screening" then visnum=0;
	else visnum=input(substr(visit,6),2.);
	cards;
101 Screening  11.13 -1
101 Week 4     12.33 28
101 Week 6     23.25 42
101 Week 14    14.25 96
101 Week 18    31.18 126
102 Week 2     21.28 14
102 Week 8     23.34 56
102 Week 14    25.21 96
;
run;


proc sort data=vv2; by subjid visnum ; run;
proc sort data=vv; by subjid visnum; run;


* Do traditional locf;
data final2(drop= v1 v2);
	retain v1 v2;
	merge vv2 vv;
	by subjid visnum;
	if first.subjid then v1=.;
	if visnum < 20 then do;
		if value =. then value=v1;
		else v1=value;
	end;
	else if 20 <= visnum < 160 then do;
		if value =. then value=v2;
		else v2=value;
	end;
run;

* tradional locf II ;
data locf2(drop=dummy);
	set vv2;
	retain dummy;
	by subjid visnum;
	if not first.subjid then do;
		if value ne . then dummy=value;
		else value=dummy;
	end;
run;


* Do DOW locf;
data final3(drop=locf);
	do until(last.subjid);
		merge vv2 vv;
		by subjid visnum;
		if value ne . then locf=value;
		else value=locf;
		output;
	end;
run;


proc compare base=final2 comp=final3;
run;