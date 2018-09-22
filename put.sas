data usingput;
	set sashelp.class;
	file myfile;
	if age le 11 then
		do;
			put name "09"x "Hello" "09"x height "09"x sex;
			put 'Hello' '09'x 'hello';
			put 50*"_" 10*"&" 10*"%" 10*"#";
			put #3 @50 name weight;
			put name 1-10;
			put (weight height age) (dollar12.2);
			put height dollar7.2 "09"x age 4.1;
			put _infile_;
		end;
run;