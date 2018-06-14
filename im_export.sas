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