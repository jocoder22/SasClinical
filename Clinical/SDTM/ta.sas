option validvarname=upcase;



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


