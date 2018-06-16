options nodate nonumber;

proc tabulate data=sasuser.empdata order=freq format=comma10.;
    class hiredate;
    var salary;
    table hiredate, salary*(n sum*f=dollar12.2 mean*f=dollar10.2);
    label hiredate="Month Hired";
    format hiredate monname.;
run;
