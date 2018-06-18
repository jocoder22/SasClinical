libname home "C:\Users\Jose\Documents\SasClinical";

* Sorting using sortseq=linguistic options, strength=position;
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

* Display the linguistic information using proc contents;
* so that other program will have access to the linguistic collation;
proc contents data=home.sortedTeam;
run;


* Sorting using sortseq=linguistic options, alternate_handling=shifted;
* this sort data without regard to variable with extra blank, punctuations
  or other characters;
proc sort data=home.extraX out=home.sortedExtra
        sortseq=linguistic(alternate_handling=shifted);
    by fullname;
run;


proc print data=home.sortedExtra;
    by fullname;
    id fullname;
run;


proc contents data=home.sortedExtra;
run;


* Sorting using sortseq=linguistic options, numeric_collation=on;
* this sort data by order of the integer within a text;
* 30th street, before 32nd street;
proc sort data=home.address out=home.address2
        sortseq=linguistic(numeric_collation=on);
    by street;
run;