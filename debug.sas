* Data set debug option is used for programm debugging ;
* this an interactive session the enable programmer to ;
* to discover logic errors - errors the produce unexpected results ;
* Add the data set debugging by using the debug option ;

data numtt / debug;
    set sashelp.class;
    if sex="F" then classHeight = Height - mean(Height);
    else if sex="M" then classHeight = Height - medium(Height);
    else classHeight is missing;
run;


* Debugger commands ;
/*
BREAK	    JUMP
CALCULATE	LIST
DELETE	    QUIT
DESCRIBE	SET
ENTER	    STEP
EXAMINE	    SWAP
GO	        TRACE
HELP	    WATCH
*/


* Break is used to set breakpoints, short form is b ;
b 7 ; * breakpoint at line 7;
b 15 after 4 ; * breakpoint at line 15 after every 4 execution of the line;