* Debugging II ;
* using symlocal and symglobl to search for macro variable scope ;
* declare macro variable scope, they have null values upon declaration ;
%global lane Road;
%local Apt Room;

* search for scope, returns 1 if found in global symbol table and Zero otherwise ;
%put %symglobl(lane);
%put %symglobl(Apt)


* search for scope, returns 1 if found in local symbol table and Zero otherwise ;
%put %symlocal(Road);
%put %symlocal(Room);


* Using %local to restrict macro variable changes to within the macro that defined the variable ;
* it also create a local macro variable in the local symbol table ;
* local variable is not valid on the open code, i.e cand declare %local outside the macro ;

%let cityname = New York;
%macro demo(name);
    %local cityname;
    %let cityname = &name;
    %put The name of the city is &name;
%mend;

%demo(Baltimore);
%put After demo execution the name of the city is &cityname;


* Using %global for global declaration ;
%global dance;
%let dance = DoggleHog;

%macro dancing(d1, d2);
    %global dance2;
    %let dance2 = Boggie;
    %put Please start with &dance and then followed by &dance2;
    %put Then do &d1 and finally &d2 , Thanks;
%mend;

%dancing(Reggae, HipPop);


* Can call global macro variable even outside the macro definition ;
%put Which dance is &dance2.?;

* search for dance2 macro variable ;
%put %symglobl(dance2);
%put %symlocal(dance2);


* Mfile is used to direct the mprint output to external file ;
* First you must name the fileref mprint ;
options mfile mlogic mprint
filename mprint "C:/mymacro/outprint.txt"
