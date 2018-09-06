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

%let cityname = New York;
%macro demo(name);
    %local cityname;
    %let cityname = &name;
    %put The name of the city is &name;
%mend;

%demo(Baltimore);
%put After demo execution the name of the city is &cityname;