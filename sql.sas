options firstobs=1 obs=1 pageno=1 ls=180 ps=100;
libname home "C:\Users\Jose\Documents\SasClinical";


/* Creating SQL Queries */
proc sql;
    select Subjid, Siteid, Gender, Age
        from home.double
        where Age < 40
        group by Gender
        Order by Age;
quit;


/* Querying multiple tables */
proc sql;
    select double.Subjid, Studyid, Gender, Txt, Dose 
        from home.double, home.treatment
        where double.Subjid = treatment.Subjid
        order by Txt;
quit;


/* Summarizing table data :
AVG, MEAN = Average or mean of values
COUNT, FREQ, N = Aggregate number of non-missing values
CSS	= Corrected sum of squares
CV	= Coefficient of variation
MAX	= Largest value
MIN	= Smallest value
NMISS = Number of missing values
PRT	= Probability of a greater absolute value of Student's t
RANGE = Difference between the largest and smallest values
STD	= Standard deviation
STDERR = Standard error of the mean
SUM	= Sum of values
SUMWGT	= Sum of the weight variable values, which is 1
T = Testing the hypothesis that the population mean is zero
USS = Uncorrected sum of squares
VAR = variance
*/
proc sql;
    select Dose, count(Dose) as NumberTxt
        from home.treatment
        group by Dose;
quit;


/* Creating table to store query results*/
proc sql;
    create table home.summary as
        select Siteid, Gender, avg(Age) as AverageAge
        from home.double
        group by Siteid Gender;
quit;