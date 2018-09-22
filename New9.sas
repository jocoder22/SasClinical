* Write message to log using putlog;
data putlog1;
    set sashelp.class;
    putlog _all_;
    putlog name sex weight height;
    putlog  name " height is " height "inches";
    putlog "NOTE: THIS WRITE NOTE message IN BLUE";
    putlog "WARNING: THIS WRITE WARNINGS message IN GREEN";
    putlog "ERROR: THIS WRITE ERROR message IN RED";
run;

data _null_;
	set sashelp.class;
	array my_arr{*} _numeric_;
	array numer{*} _character_;
	put my_arr(*) numer(*);
	put name age sex weight height;
	putlog name age sex weight height;
    put _ALL_;
	putlog _all_;
run;


* The integer in operators;
data badair;
	set sashelp.air;
	if air in(0:186);
run;


* using ifn and ifc;
data putinfile2;
	infile datalines missover;
	input name $ age sex $;
    age = ifn(age le 0, 50, age);
	datalines;
Mark . M
Uju 35 F
Kelly . 
Keth 24 F
;
run;