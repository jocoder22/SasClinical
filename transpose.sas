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


proc transpose data=thome.prices out=thome.tprices name=SalePrices;
    id Product;
run;