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