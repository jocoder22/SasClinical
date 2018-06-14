libname home "C:\Users\Jose\Documents\SasClinical";
%let folder =/folders/myshortcuts/SasClinical;
%let exfold =/folders/myshortcuts/SasClinical/I_Export;  

/* Importing data/files using Proc import*/
proc import out=home.mydata
	datafile="&folder/mydata.xls"
	dbms=xls replace;
	getnames=no;
	sheet=Test;
	datarow=8;
run;
