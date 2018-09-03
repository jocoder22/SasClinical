* Import CDISC  SAS transport file;
libname sastrans XPORT "C:\adeg.xpt";
libname muser "C:\sastraining\sasTransport";


* Using Sql procedure ;
proc copy in=sastrans out=muser;
    select egk;
run;


* Using dataset step ;
data sastrans.ekg;
    select muser.ekg;
end;