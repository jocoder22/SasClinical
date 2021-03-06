options pageno=1 nodate linesize=80 pagesize=60;  
filename outfil "C:Documents/home/putlogg.txt";

data ExScores;
   infile datalines;
   input LastName $ FirstName $ Maths Chemisty Biology;
   datalines;
Gaylle Nancy 80 92 27
Martin Micheal 95 91 92
Gomez Sebastine 91 98 . 
Koshi Shauan 80 87 .
Vancovar Maurine  98 . 98
Kelly Wishdony 92 85 .
;
run;

proc print data=ExScores;
run;



DATA error2;
  set ExScores;
  length reviewed $ 4;
   if Maths le 90 then
      do;
         file log;
         put 'Score is less than 90 ' Maths=;
         _error_=1;
         error "Maths is less than or equals 90 " LastName= FirstName=;
         reviewed = "***";
         file outfil;
         put LastName FirstName maths chemistry biology reviewed;
         putlog "NOTE: Maths score less than or equals 90 "  maths= 5.2;
         putlog "WARNING: " LastName FirstName " maths score is less than or equals 90";
         putlog "ERROR: Check log for errors";  
      end;
      else reviewed = "Good";
run;


proc print data=error2;
run;
