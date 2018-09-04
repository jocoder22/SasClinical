* This demonstrates some sql functions ;
* creating macro variable using into ;
proc sql;
    select monotonic() as obs, name, age 
    into :name1 - :name19, :age1 - :age19
    from sashelp.class;
quit;