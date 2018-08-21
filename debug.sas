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
