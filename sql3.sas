* This demonstrates some sql functions ;
* creating macro variable using into ;
proc sql;
    select name into names1 :- name14
    from sashelp.class;
quit;