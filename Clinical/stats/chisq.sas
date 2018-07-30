* Chi-square test;
* Chi-square test is useful for detection of general association not particular relationship 
* between treatment and categorical response i.e ordinal and nominal in clinical trial;
* this is usually using proc freq with chisq option;
data chiTest;
    input trt $ adae $ adct;
    datalines;
Active Y 50
Active N 28
Placebo Y 30
Placebo N 78
; 
run;

