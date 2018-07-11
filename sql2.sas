libname home "C:\Users\Jose\Documents\SasClinical\sql2";


* Create table with variable names and attributes;
proc sql;
    create table sqlTable1 (name char(10), age num, gender char);
quit;


* fill table with with values;
proc sql;
    insert into sqlTable1
        values('Mary', 56, 'F')
        values('John', 67, 'M')
        values('Anna', 43, 'F')
        ;
quit;


* Using set statement to insert values;
* Here, the order don't matter;
proc sql;
    insert into sqlTable1
        set name='Kelly', age=51, gender='M'
        set gender='F', name='Jane', age=39
        ;
quit;


* Print using select statement;
proc sql;
    select * from sqlTable1;
quit;

proc sql;
    select name, gender from sqlTable1;
quit;


* sorting the data;
proc sql;
    create table sqlTable2 as 
        select * from sqlTable1
        order by gender desc, age ;
quit;


* sort by position of variable;
proc sql;
    create table sqlTable3 as   
        select * from sashelp.class
        order by 2, age desc;
quit;


* create format;
proc format libray=library;
    value $genderfmt2 
        "F"="Female"
        "M"="Male";
run;


* Apply formats and rename variables;
proc sql;
    create table sqlTable4 as   
        select name as SubName 'Student Name',
               age as Age,
               sex as Gender foramt=$genderfmt2.,
               Height as Height_cm 'Height in cm',
               Weight as Weight_kg 'Weight in Kg'
        from sashelp.class;
quit;


proc sql;
    create table sqlTable4 as   
        select name as SubName 'Student Name',
               age as Age,
               sex as Gender foramt=$genderfmt2.,
               Height as Height_cm 'Height in cm',
               Weight as Weight_kg 'Weight in Kg'
        from sashelp.class
        where Gender="F";
quit;


* create new variable;
proc sql;
    create table sqlTable5 as   
        select name as SubName 'Student Name',
               age as Age,
               sex as Gender foramt=$genderfmt2.,
               Height as Height_cm 'Height in cm',
               Weight as Weight_kg 'Weight in Kg',
               age+12 as AgePlus,
        case when age <= 20 then 'Teenager'
            when age  > 20 and age <= 30 then 'Young'
            when age > 30 and age <= 40 then 'Middle Age'
            else 'Older' end as AgeGrp
        from sashelp.class
        where Gender="F";
quit;


* Using newly created variables, calculated keyword;
proc sql;
    select * , (weight**2) as weightSq, calculated weightSq/Height as Nweight
    from sashelp.class;
quit;


* using distinct function;
proc sql;
    select distinct(age) from sashelp.class;
quit;


proc sql;
    select count(distinct age) as Agedist, count(distinct sex) as SexCat
    from sashelp.class;
quit;


* describe and delete table (using drop);
proc sql;
    describe table sqlTable5;
quit;

proc sql;
    drop table sqlTable5;
quit;


* Using sas functions ;
proc sql;
	select Weight, ceil(Weight) as Weight2, Height, 
	floor(Height) as Height2, ceil(Height) as HeightC
	from sashelp.class;
quit;


* generating statistics;
proc sql;
    select sex, count(age) as n, min(age) as MinAge, 
        mean(Height) as Ave_Height foramt=6.2, mean(Weight) as Ave_Weight format=6.2
    from sashelp.class
    group by sex;
quit;

* sql operators;
* Union all, Union, intersect, except;

* generate test dataset;
data ftable mtable;
    set sashelp.class;
    if sex='F' then output ftable;
    else if sex ='M' then output mtable;
run;
* union all combines two tables without sorting;
proc sql;
    select * from ftable
    union all
    select * from mtable
quit;

* union combines two tables with sorting;
* sorting using all variables sequentially starting with the first observation;
proc sql;
    select * from ftable
    union 
    select * from mtable
quit;

* Intersect returns common observations matched on selected variable;
* Below no observation was select, observation must match on all variables;
proc sql;
	select * from ftable
	intersect
	select * from mtable;
quit;


* Here matched observation(s) on age, Weight and Height is returned;
proc sql;
	select age, Weight, Height from ftable
	intersect
	select age, Weight, Height from mtable;
quit;

* Except returns non matching observations in table1;
* Here table1 is ftable;
proc sql;
	select age, Weight from ftable
	except
	select age, Weight from mtable;
quit;



* feedback and outobs= options;
* feedback option output final transformed code to the log;
* outobs= is used to limit the number of observation in the output;
*  and a warning thus -- WARNING: Statement terminated early due to OUTOBS=10 option.;
proc sql feedback outobs=10;
    select * from sashelp.class;
quit;


* selecting range of observation using monotonic() ;
proc sql feedback;
	select * from sashelp.class
    where monotonic between 12 and 18;
quit;



* Alter table;
* can add or drop variable;
proc sql;
    alter table ftable add race char(12);
quit;

proc sql;
    alter table ftable drop weight;
quit;


* Duplicating or Copying;
proc sql;
    create table dup1 as
	select *, sex as Gender 
	from sashelp.class;
quit;


proc sql;
	create table dup2 as
	select *
	from sashelp.class;
	alter table dup2 add Gender char;
	update dup2 set Gender=sex;
quit;


proc sql;
	create table dup3 as
	select *
	from sashelp.class;
	alter table dup3 modify sex char(6);
	update dup3 set sex= case when sex="F" then "Female"
	else "Male"
	end;
quit;