data loan1; 
    grossloan = 299900;
    downpayment = 14695;
    monthlypay = 2144;
    interest = 0.04543;
    netloan = grossloan - downpayment;
    do year = 1 to 30;
        do month = 1 to 12;
        netloan = netloan - monthlypay;
        totalpayment + monthlypay;
        end;
        netloan = netloan + (netloan * interest);
    end;
    loan = netloan;
run;



data mortage(drop=netloan downpayment); 
    grossloan = 299900;
    downpayment = 14695;
    monthlypay = 2144;
    interest = 0.04543;
    netloan = grossloan - downpayment;
    
    do while(netloan ge 0);
    	year + 1;
	        do month = 1 to 12 while(netloan ge 0);
		        netloan = netloan - monthlypay;
		  		totalpayments + monthlypay;
	  		end;
        netloan = netloan + (netloan * interest);
    end;
    loan = netloan;
run;

proc print data=loan1;
run;


data mortageCalc;
    pAndi = 2154;
    tax = 565;
    insurance = 57;
    HOAFees = 374;
    time = 10 * 12;
    monthlypay = pAndi + insurance + tax + HOAFees;
    do i = 1 to time;
        Total + monthlypay;
    end;
run;