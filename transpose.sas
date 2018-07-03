options nodate pageno=1 linesize=120 pagesize=90;

libname thome "C:\Users\Jose\Documents\SasClinical\proc\tranpose";

data thome.prices;
    input Product $ Code $ Gprice Discount Fprice;
    datalines;
Tv x3487 860 50 810
Radio r7489 560 10 550
Mwave m5892 98 5 93
Pc p8931 1240 40 1200
Mouse j8910 40 3 37
Hphone k9013 56 3 53
Heater h9234 590 50 540
Iron i7569 120 10 110
;


* use transpose function to make the data long;
* You can use options like, prefix, suffix, name;
* Can use statements like, id, idlabel, by (rememeber data must be sorted), var, copy;
* Id statement select the variable values to use as column names for transposed data;
* Here Values in Product variable are used as column names;
* Transpose function uses COL1 - COL.. if id statement is omitted;
proc transpose data=thome.prices 
               out=thome.tprices 
               name=SalePrices;
    id Product;
run;


* Using proc print to see the data ;
* proc transpose don't print output;
proc print data=thome.tprices;
run;


* use var statement to select variable to include in the transposition;
* Transpose function works only on numeric variables if var is omitted;
proc transpose data=thome.prices 
               out=thome.FFprices 
               name=SalePrices;
    var Fprice;
    id Product;
run;

* Using proc print to see the data ;
* proc transpose don't print output;
proc print data=thome.tprices;
run;
