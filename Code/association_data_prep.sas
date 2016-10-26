libname andrew 'C:\Users\ankram\Documents\Papers & Reports\Association Analysis\SAS Conference\Datasets';
%let path=C:\Users\ankram\Documents\Papers & Reports\Association Analysis\SAS Conference\Datasets;
/*Data Prep for Association Analysis for Ta Feng data set*/

/*Load D11 Data set for November, 2000*/
data November_2000;
	infile "&path\D11txt.txt" dlm=";" firstobs=2;
	input  Date ANYDTDTM. Customer_ID $ Age $ 
		   Area $ subclass $ :8. 
           ProdId $ :20. AMT Asset SalePrice;
run;

/* Load D12 Data set for December, 2000*/
data December_2000;
	infile "&path\D12txt.txt" dlm=";" firstobs=2;
	input  Date ANYDTDTM. Customer_ID $ Age $ 
		   Area $ subclass $ :8. 
           ProdId $ :20. AMT Asset SalePrice;
run;

/*Load D01 Data Set for January, 20001 Data*/
data January_2001;
	infile "&path\D01txt.txt" dlm=";" firstobs=2;
	input  Date ANYDTDTM. Customer_ID $ Age $ 
		   Area $ subclass $ :8. 
           ProdId $ :20. AMT Asset SalePrice;
run;

/*Load D12 Data Set for February, 2001 Data*/
data February_2001;
	infile "&path\D02txt.txt" dlm=";" firstobs=2;
	input  Date ANYDTDTM. Customer_ID $ Age $ 
		   Area $ subclass $ :8. 
           ProdId $ :20. AMT Asset SalePrice;
run;


/*join the four data sets*/
Data All_Transactions;
	set November_2000 December_2000 January_2001 February_2001;
run;


/*Sort Datasets*/
proc sort data=All_Transactions out=all_transactions_v2;
by date customer_ID;
run;

/*Add ID Counter Variable*/
data all_transactions_v3;
	set all_transactions_v2;
	by date customer_ID;
	retain ID 0;
	if first.customer_ID then ID=ID+1;
run;


/*Resort dataset for sequential analysis*/
proc sort data=november_2000_v3 out=november_2000_seq;
	by customer_ID  ID;
run;
