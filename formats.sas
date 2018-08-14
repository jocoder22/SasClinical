* Creating user defined formats;
proc format;
    value $gender "F" = "Female"
                  "M" = "Male"
                  ;
    value agegrp  11 - 12 = "Young"
                  13 - 14 = "Middle"
                  15 - high = "Old"
                  ;
run;