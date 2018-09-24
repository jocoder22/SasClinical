option validvarname=upcase;

data patient_visits;
	input Name $ (visit1-visit4)(: mmddyy10.);
	format visit1-visit4 mmddyy10.;
	datalines;
Joe 01/05/2011 01/15/2011 01/25/2011 02/03/2011
Sam 01/07/2011 01/17/2011 01/27/2011 02/10/2011
Ron 01/09/2011 01/19/2011 01/29/2011 03/15/2011
Bob 01/11/2011 01/21/2011 01/31/2011 02/01/2011
;
run;


* Rotate the data to long form;
data long;
	set patient_visits;
	array visitt{4} visit1-visit4;
	do i=1 to dim(visitt);
		dateofvisit=visitt{i};
		output;
	end;
	format dateofvisit mmddyy10.;
	drop visit1-visit4 i ;
run;


* Rotate to wide form;

