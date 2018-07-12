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


optiions ls=200 nocenter nodata nonumber; title;
proc format;
    value $gender 'M'='Male' 'F' = 'Female';
run;


proc printto print="C:\Users\Jose\Documents\SasClinical\listing\report1.txt"
    log="C:\Users\Jose\Documents\SasClinical\listing\report1_log.txt"
run;

proc report data=advs1 nowd headskip headline split='*';
    column ('--' usubjid sex country age trtpn trtp param avisitn avisit aval);
    define param/width=35 order;
    define usubjid / 'Subject*Identifier' order;
    define sex / group format=$gender.;
    define country/ order width=10;
    define age/ order;
    define trtpn/ noprint order;
    define trtp/ order;
    define avisitn/ noprint order;
    define avisit/ order;
    compute before _page_;
        line @10 'BP3304-002' @120 'l_vitals.sas';
        line ''; line '';
        line @40 'Subject Vitals Signs information - listing';
        line '';
    endcomp;
    compute after;
        line @2 135*'-'; line '';
    endcomp;
quit;

proc printto;
run;


* In tables we generate statistics;
