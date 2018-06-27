libname home "C:\Users\Jose\Documents\SasClinical\functions";


data home.func1;
    infile datalines;
    input Describe $32.;
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
    desUpper = upcase(Describe);
    desLower = lowcase(Describe);
    desProper = propcase(Describe);
run;



* Using compress and compbl funtions;
* compbl removes extra blanks, i.e only one blank remaining;
data home.c_comp;
    infile datalines;
    input name $24.;
    datalines;
Jane   Easiys
Mark      kolwein
Owen    Nancy
;
run;

* Compress removes specified xter or list of xters;
* if no list or xter specified, compress will remove all blanks;
* if blank is not in specified list, blank will not be removed.;
data home.c_comp2;
    set home.c_comp;
    Name2 = compress(name);
    Name3 = compbl(name);
    Name4 = lowcase(name);
run;

proc print data=home.c_comp2;
run;



* Using substr function;
data home.suhu;
    set home.c_comp2;
    Name5 = Upcase(substr(Name4,1,4));
    substr(Name4,5,4) = "AAA";
run;



* indexw, index, indexc;
* indexw, finds whole word: strings separated by spaces, or space and end/beginging of string;
* index returns the position of the substring while indexc returns position of xter;
data _null_;
    header = "World most beautiful island";
    head1 = indexw(header, 'beautiful');
    head2 = indexw(header, 'beauty');
    head3 = indexc(header, "af");

    put header=;
    put head1=;
    put head2=;
    put head3=;
run;




* find and findc;
* find returns the positon of a substring;
* findc return the position of a xter;
data _null_;
    address = "41 Marleong street";
    find1 = find(address, 'Marleong');
    find2 = findc(address, "M");

    put find1=;
    put find2=;
run;



* count, countc;
* count returns the number of occurance of a string;
* countc returns the number of occurances of a xter;
data _null_;
    counter = "This is the counter in this history piscis";
    counter1 = count(counter, "is");
    counter2 = countc(counter, 'isc');

    put counter1=;
    put counter2=;
run;


Scan function
* Translate function replaces specified xters in a character string;
data _null_;
myword = "Sensitised";
newword = translate(myword, "z", "s");
put myword= newword=;
run;


* Tranwrd function replace word strings;
* if the string has no length, the Tranw return a length of 200;
* this differs from translate function that replaces xter;

data home.rolls;
    infile datalines;
    input states :$12 @@;
    OldName = tranwrd(states, "New", "Old");
    datalines;
New York New Jersey New London
New Orleans New Mexico New Jackon
;
run;


