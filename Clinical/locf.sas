* Last observation carried forward(LOCF);
proc format;
	value $visit "1"="Screening"
				"2"="Baseline"
				"3"-"6"="Routine"
				"7"="Closeout"
				"8"="Follow-up"
				;
run;



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
