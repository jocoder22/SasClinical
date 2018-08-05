option validvarname=upcase;

* This will transpose(Normalise) our data;

data vsflat2;
	set vssort;
		by usubjid;
		keep usubjid visit1-visit7;
		retain visit1-visit7;
		array visit{7};
		if first.usubjid then call missing(of visit[*]);
			visit{visitnum}=vsstresn;
		if last.usubjid;
run;