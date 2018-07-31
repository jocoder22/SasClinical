* Select is used when dealing with long series of mutually exclusive
* condition instead of IF ... THEN ... Else IF ... statement;
data slect;
    set sashelp.class;
    select(agegrp);
        when("child") allowance]=1500;
        when("Adult") 
            do;
            if gender="F" then allowance=1200;
            else if gender "M" then allowance=1000;
            end;
        when("Senior") allowance=1250;
        otherwise;
    end;
run;


* without select expression;
data snoexp;
    set sashelp.class;
    select;
        when (gender="F") benefit=1200;
        when (gender="M") benefit=1000;
        otherwise;
    end;
run;