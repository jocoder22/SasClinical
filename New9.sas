* Write message to log using putlog;
data putlog1;
    set sashelp.class;
    putlog _all_;
    putlog name sex weight height;
    putlog  name " height is " height "inches";
    putlog "NOTE: THIS WRITE NOTE message IN BLUE";
    putlog "WARNING: THIS WRITE WARNINGS message IN GREEN";
    putlog "ERROR: THIS WRITE ERROR message IN RED";
run;

