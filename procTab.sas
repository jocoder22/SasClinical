options nodate nonumber;

proc tabulate data=sasuser.empdata order=freq format=comma10.;
    class hiredate;
    var salary;
    table hiredate, salary*(n sum*f=dollar12.2 mean*f=dollar10.2);
    format hiredate monname.;
    label hiredate="Month Hired";
    title "Total Salary for Staff by Hire Month";
run;
