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