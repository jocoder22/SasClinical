option validvarname=upcase;

* Add se domain;
%let varkeep=studyid domain usubjid etcd element taetord epoch sestdtc seendtc;
data se;
    attrib studyid  label='Study Identifier'   length=$6
            domain  label='Domain Abbreviation'   length=$2
            usubjid  label='Unique Subject Identifier'   length=$22
            * seseq  label='Sequence Number'   length=8;
            etcd  label='Element Code'   length=$6
            element  label='Description of Element'   length=$9
            seupdes  label='Description of Unplanned Element'   length=$40
            sestdtc  label='Start Date/Time of Element'   length=$10
            seendtc  label='End Date/Time of Element'   length=$10
            taetord  label='Planned Order of Elements with Arm'   length=8
            epoch  label='Epoch'   length=$9
    ;
    set sasuser.svdtc(keep=pt stud_sit visit vis_d) ;
    studyid="SCL002";
    domain="SE";
    usubjid=studyid||'-'||strip(stud_sit)||"-0"||strip(substr(pt, 5, 1));
    /* seseq=;
    if visit in (1, 10) then  do;    
        etcd="SCREEN"; element="Screening"; taetord=1; epoch="Screening";
    end;
        if visit=20 then  do;    
        etcd="BASE"; element="Baseline"; taetord=2; epoch="Treatment";
    end;
        if visit=30 then  do;    
        etcd="TREAT"; element="Treatment"; taetord=3; epoch="Treatment";
    end;
        if visit=40 then  do;    
        etcd="FU"; element="Follow-up"; taetord=4; epoch="Follow-up";
    end; */

     if visit in (1, 10) then  do;    
        etcd="SCRN"; element="Screen"; taetord=1; epoch="Screening";
    end;
        if visit=20 then  do;    
        etcd="K"; element="SCLA"; taetord=2; epoch="Treatment";
    end;
        if visit=40 then  do;    
        etcd="FU"; element="Follow-up"; taetord=3; epoch="Follow-up";
    end;

    sestdtc=put(vis_d, yymmdd10.);
    seendtc=put(vis_d, yymmdd10.);
    keep &varkeep;
run;


* Generating sequence number;
* first sort the data;
proc sort data=se; 
    by usubjid sestdtc etcd;
run;

data se;
    set se;
    attrib seseq  label='Sequence Number'   length=8;
    by usubjid sestdtc etcd;
    if first.usubjid then seseq=1;
    else seseq+1;
    where etcd is not missing;
run;