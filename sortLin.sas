libname home "C:\Users\Jose\Documents\SasClinical";

* Sorting using sortseq=linguistic option;
* this sort data without regard to variable case;
proc sort data=home.team out=home.sortedTeam
        sortseq=linguistic(strength=primary);
    by Country position;
run;

proc print data=home.sortedTeam;
    by country position;
    id country position;
    title "World Cup Teams";
    title2 "Sorted using sortseq linguistic option";
run;


