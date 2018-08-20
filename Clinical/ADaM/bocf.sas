* Baseline observation carried forward(BOCF);
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

proc sort data=height out=sortH;
     by subjid visit;
run;


* Generate baseline;
data baseheight;
    do until(last.subjid);
        set sortH(where=(visit not eq 1));
        retain baseline;
        by subjid;
        if visit eq 2 then baseline=height;

        * if height for visit 2 is missing then locf to become baseline ;
        else if baseline = . and height ne . then baseline=height; 
        output;
    end;
run;



* Generate baseline flag;

data baseFlag;
    set heama;
    by subjid visit;
    retain basefl;
    if first.subjid then basefl = " ";
    if visit = 2 then basefl = "Y";
    label basefl = "Visit Baseline Flag"
run;


data bflag2;
    do until (last.subjid);
        set heama;
        by subjid visit;
        if visit = 2 then basefl = "Y";
        else basefl = " ";
        output;
    end;
    label basefl = "Visit Baseline Flag"
run;