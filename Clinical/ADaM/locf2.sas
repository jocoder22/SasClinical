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


