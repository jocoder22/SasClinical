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


options nonumber nodate;
title;

ods escapechar= "\";
title 'This is the document with page x of y'
	j=r 'Page \{pageof}';
ods rtf file="/folders/myfolders/Odspage/pageof.rtf";
proc print data=sashelp.air;
run;
ods rtf close;


ods escapechar= '\';
title 'This is the document with page x of y'
	j=r 'Page \{thispage} of \{lastpage}';
ods pdf file='/folders/myfolders/Odspage/pagespdf1.pdf';
options nonumber nodate center ls=max;
proc print data=sashelp.air;
run;
ods pdf close;