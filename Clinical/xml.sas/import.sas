* Using XML libname engine to read xml data;
filename myxml "c:\file33.xml";
libname xml2 xmlv2 xmlmap=xml_map;
filename xml_map "C:\xml_map.map";


proc contents   
    data=xml2.myxml;
run;

