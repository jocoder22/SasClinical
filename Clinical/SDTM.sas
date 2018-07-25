* Generating the TE domain(dataset);
options validvarname=upcase;
data te;
    attrib studyid    label='Study Identifier'  length=$10
           domain    label='Domain Abbreviation'  length=$2
            ectd    label='Element Code'  length=$8
            element    label='Description of Element'  length=$200
            testrl    label='Rule for Start of Element'  length=$200
            teenrl    label='Rule for End of Element'  length=$200
            tedur    label='Planned Duration of Element'  length=$20
    ;
    studyid = "SCL002";
    domain = "TE";
    ectd = "SCRN";
    element = "Screen";
    testrl = "Informed Consent";
    teenrl = "Screening Assessments are complete, up to 1 week after start of Element";
    tedur = "P7D"; output;

    ectd = "K";
    element = "SCLA";
    testrl = "First dose of study drug";
    teenrl = "4 days to 1 week after start of element"; output;

    ectd = "FU";
    element = "Follow Up";
    testrl = "After the last PK plasma sample or 1 week after last dose";
    teenrl = "Ends 1 weeks after start of element"; output;
run;



* Add ta domain;
data ta;
    attrib studyid   label='Study Identifier'  length=$10
            domain   label='Domain Abbreviation'  length=$2
            armcd   label='Planned Arm Code'  length=$8
            arm   label='Description of Planned Arm'  length=$200
            taetord   label='Order of Element within Arm'  length=8
            etcd   label='Element Code'  length=$8
            element   label='Description of Element'  length=$200
            tabranch   label='Branch'  length=$200
            tatrans   label='Transition Rule'  length=$200
            epoch   label='Epoch'  length=$200
    ;
    studyid="SCL002";
    domain="TA";
    tabranch="";
    tatrans="";
    armcd="A";
    arm="Adult";
    etcd="SCRN"; element="Screen"; taetord=1; epoch="Screen"; output;
    etcd="K"; element="SCLA"; taetord=2; epoch="Treatment"; output;
    etcd="FU"; element="Follow-Up"; taetord=3; epoch="Follow-Up"; output;

    armcd="C"; arm="Child";
    etcd="SCRN"; element="Screen"; taetord=1; epoch="Screen"; output;
    etcd="K"; element="SCLA"; taetord=2; epoch="Treatment"; output;
    etcd="FU"; element="Follow-Up"; taetord=3; epoch="Follow-Up"; output;
run;



* Add se domain;
%let varkeep=studyid domain usubjid etcd element taetord epoch sestdtc seendtc;
data se;
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
    by usubjid sestdtc etcd;
    if first.usubjid then seseq=1;
    else seseq+1;
    where etcd is not missing;
run;