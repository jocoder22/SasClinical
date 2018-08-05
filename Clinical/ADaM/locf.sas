* Last observation carried forward(LOCF);
* create $visit format;
proc format;
	value $visit "1"="Screening"
				"2"="Baseline"
				"3"-"6"="Routine"
				"7"="Closeout"
				"8"="Follow-up"
				;
run;



* create dataset;
data height;
    do subjid=1 to 100;
        do visit=1 to 8;
            height=ceil(220 * ranuni(2345));
            if height < 160 then height = .;
            visitc=put(visit,1.);
            output;
        end;
    end;
    format visitc $visit.;
run;


* Do traditional locf;
data locf;
	set height;
	by subjid;
	retain locf;
	if first.subjid then locf=.;
	if height ne . then locf=height;
    else height=locf;
run;


* Do DOW locf;
data locf2;
    do until(last.subjid);
        set height;
        by subjid;
        if height ne . then locf=height;
        output;
    end;
run;


* Generate baseline;
data baseheight;
    do until(last.subjid);
        set locf2;
        by subjid;
        if visit eq 2 then baseline=height;
        else if baseline = . and height ne . then baseline=height;
        if visit eq 1 then baseline = .;
        output;
    end;
run;