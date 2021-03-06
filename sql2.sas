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
* calculated keyword allows you to directly used newly created variable ;
proc sql;
    select * , (weight**2) as weightSq, Height/ calculated weightSq as Bmi
    from sashelp.class;
quit;

proc sql;
    select * , (height*0.0254)**2 as Heightsq, 
    	weight/calculated Heightsq as Bmi
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

* This select distinct combination of age and sex ;
proc sql;
	select distinct age,sex
	from sashelp.class;
quit;


* describe and delete table (using drop);
proc sql;
    describe table sqlTable5;
quit;


* This will delete the table ;
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






* sql set operators;
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
* Here table1 is ftable, so will print non matching observations in ftable ;
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
    where monotonic() between 12 and 18;
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



* modify a variable values ;
proc sql;
	create table dup3 as
	select *
	from sashelp.class;
	alter table dup3 modify sex char(6);
	update dup3 set sex= case when sex="F" then "Female"
	else "Male"
	end;
quit;


* Coalesce function to replace missing values;
proc sql;
	create table dup4 as
	select coalesce(name, "Unknown") as Name, 
	coalesce(age,0) as Age,coalesce(gender,"unk") as Gender 
	from table2;
quit;


* Joins;
* simple, inner, outer(left, right, full);
* Natural, self, Cross , Union;

* Simple Join, using where statement to combine multiple tables;
proc sql;
	select * from ftable, mtable
	where ftable.weight=mtable.weight;
quit;


* Inner joins for only two tables;
proc sql;
	select * from ftable inner join mtable
	on ftable.weight=mtable.weight;
quit;


* Outer Joins;
* left outer join, take all from the leftmost table and add matches to the right table;
proc sql;
	select * from ftable left join mtable
	on ftable.weight=mtable.weight;
quit;

* Right outer join, take all from the rightmost table and add matches to the left table;
proc sql;
	select * from ftable right join mtable
	on ftable.weight=mtable.weight;
quit;



* Natural join, makes join using variables common to both tables;
* rename sex in ftable;
proc sql;
    create table ftable2 as
    select name as Fname, sex as Gender, Weight, Height
    from ftable;
quit;

proc sql;
	select * from ftable2 natural join mtable;
quit;


* Self join;
* uses where to subset the dataset;
proc sql;
	select * from ftable
	where age ge 35;
quit;


* Cross join make a cross joint, attached each observation left to all observation on the right table;
* Total number of n X m observations, n is number of observations in left table;
* while m is the number of observations in the right table;
proc sql;
	select * from ftable cross join mtable
quit;


* Union join;
* Stacks the tables;
proc sql;
	select * from ftable union join mtable;
quit;