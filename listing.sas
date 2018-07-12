libname home "C:\Users\Jose\Documents\SasClinical";
filename mylst "C:\Users\Jose\Documents\SasClinical\listing";


data old;
    infile datalines;
    input ID $ Sex $ Race $ Age Ageu $;
    datalines;
101 M Asian 35 years
102 M Europe 48 years
103 F African 45 years
104 M Asian 39 years
105 F Chinese 32 years
106 F Asian 30 years
;
run;



* In listing, we generate a listing output. No statistics is calculated;
data new;
    set old;
    col1 = strip(id)||'/'||strip(sex)||'/'||strip(race);
    * can use catx(/, id, sex, race;)
    col2 = strip(put(age,2.))||'/'||strip(ageu);
    keep col1 col2;
    title "Listing of Demographic Data";
run;
title;


* listing using sql;
proc sql;
    create table advs1 as 
    select l.usubjid, l.trtp, l.trtpn, l.avisitn, l.avisit, l.param, l.aval,
        r.country, r.sex, r.age  from sasuser.advs as l left join sasuser.ads1 as r
    on l.usubjid=r.usubjid;
quit;



* In tables we generate statistics;
