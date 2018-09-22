filename myfile "C:\Users\Jose\Documents/myfolders/tab.txt";
filename myfile2 "C:\Users\Jose\/myfolders/putinfile.txt";

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
    else 
        do;
            count + 1;
            put "(" count 2.0 ")"  @;
            put +1 name " is of height " height " inches";
        end;
run;



data putinfile;
	input name $ age sex $;
	file myfile2;
	put _infile_;
    put @age name;
	put @(2*age) name;
    put @(2*age) name /
	  @5 "gender " sex;
    put @1 name overprint @1'#######';
	datalines;
Mark 49 M
Uju 35 F
Kelly 56 M
Keth 24 F
;
run;
