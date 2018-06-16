libname home "C:\Users\Jose\Documents\SasClinical";
%let folder =/folders/myshortcuts/SasClinical;
%let exfold =/folders/myshortcuts/SasClinical/I_Export;  

/* Importing data/files using Proc import*/
/* Import excell file*/
proc import out=home.mydata
	datafile="&folder/mydata.xls"
	dbms=xls replace;
	getnames=no;
	sheet=Test;
	datarow=8;
run;

/* Import sheet range*/
proc import out=home.mydataRange
	datafile="&folder/mydata.xls"
	dbms=xls replace;
	getnames=no;
	range='Test$A1:F22';
run;


/* Importing Microsoft Access Table*/
proc import datatable=Flight
		out=home.flight
		dbms=access replace;
	database="&folder/acs.mdb";
run;


/* Import cvs file */
proc import datafile="&folder/mydata.cvs"
        out=home.mycvs
        dbms=cvs replace;
        getnames=no;
run;



/* Import other delimited file */
proc import datafile="&folder/mydata22.txt"
        out=home.mytext
        dbms=dlm replace;
        delimiter=" ";
        getnames=no;
run;



/* Exporting files */
proc export outfile="&folder/mycars.txt"
    data=sashelp.cars
    dbms=dlm;
    delimiter=" ";
run;



/* Exporting Access files */
proc export outtable=cars
    data=sasuser.cars
    dbms=access;
    database="&folder/Accesscars.mdb";
run;