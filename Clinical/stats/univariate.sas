* Generate dataset;
data adsl;
    infile datalines dsd missover dlm=" ";
    input usubjid $3. sex $1. height weight @@;
    datalines;
101 F 122 234 111 M 162 234 121 F 153 240 122 M 144 242
102 F 109 238 122 F 122 236 123 M 173 235 126 M 152 270
103 M 113 250 113 M 162 251 133 M 143 252 127 F 182 251
104 M 191 248 105 F 141 180 125 F 132 190 128 M 149 259
106 F 123 235 110 M 165 238 112 F 158 249 114 M 154 232
107 F 110 248 115 F 126 232 116 M 183 245 117 M 142 278
108 M 123 255 118 M 169 259 119 M 153 242 120 F 189 255
109 M 192 249 124 F 161 188 129 F 142 199 130 M 169 269
;
run;


* Generate all tables for selected numeric variables;
proc univariate data=adsl;
    var height weight;
run;


* using ods select to select specific output;
title 'Height and Weight descriptive statistics';
ods select BasicMeasures Quantiles;
proc univariate data=adsl;
    var height weight;
run;


