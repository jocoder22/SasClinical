libname home "C:\Users\Jose\Documents\SasClinical\functions";


data home.func1;
    infile datalines;
    input Describe : $32;
    datalines;
This is the best eassy
But i have to write more
Letters in this eassy
Are needed just for demo
Have a wonderful day
See you in next session
;
run;


data home.fullname;
    infile datalines;
    Label Fname="First Name"
          Lname="Last Name"
          FullName="Full Name";
    length FullName $26;
    input Fname :$10. Lname :$12.;
    FullName = catx(" ", Fname, Lname);
    * can use, call catx(" ", FullName, Fname, Lname);
    datalines;
Jose Hargver
Mary Loveensten
Peterson Klevson
Jean Ortgeon
Marleong Bartsisone
Robertson Nowerginma
;
run;


/* Demonstrate case functions*/
/* Upcase, lowercase, propcase */

data caseF;
    set home.func1;
    desUp = upcase(Describe);
    desLo = lowcase(Describe);
    desPo = propcase(Describe);
run;



* Using compress and compbl funtions;
data home.c_comp;
    infile datalines;
    input name : $24.;
    datalines;
Jane   Easiys
Mark      kolwein
Owen    Nancy
;
run;


