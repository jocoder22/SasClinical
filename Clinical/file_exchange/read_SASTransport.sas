* Import CDISC  SAS transport file;
libname sastrans XPORT "C:\adeg.xpt";
libname muser "C:\sastraining\sasTransport";

proc copy in=sastrans out=muser;
    select egk;
run;