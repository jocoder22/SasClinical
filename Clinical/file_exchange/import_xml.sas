* Using XML libname engine to read xml data;

libname xml2 xmlv2 xmlmap=xml_map;
filename xml_map "C:\xml_map.map";
filename myxml "c:\file33.xml";


proc contents   
    data=xml2.myxml;
run;

proc print
    data=xml2.myxml;
run;