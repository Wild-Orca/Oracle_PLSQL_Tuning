In this section, we explore SQL and PL/SQL commands for understanding cardinality.

***Part 1:
1.1 Execute the Query
	SELECT /*+ GATHER_PLAN_STATISTICS */ COUNT(*) 
	  FROM YOUR_TABLE;
  	SELECT * 
	  FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(null,null,'ALLSTATS LAST'));

1.2 Lets get the statistics data of the table
	SELECT TABLE_NAME 
		 , NUM_ROWS 
	  FROM USER_TAB_STATISTICS 
	 WHERE TABLE_NAME = 'YOUR_TABLE';

1.3 Cardinality estimated value (NUM_ROWS * ESTIMATED_RATIO)
    SELECT NUM_ROWS * ESTIMATED_RATIO 
	  FROM DUAL;

***Part 2:
2.1 Always the estimated number is same.....  num_rows * predicate_selectivity(raio)
	SELECT /*+ GATHER_PLAN_STATISTICS */ COUNT(*) 
	  FROM YOUR_TABLE;
	SELECT * 
	  FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(null,null,'ALLSTATS LAST'));


2.2 Get the predictive_selectivity value
	SELECT NUM_DISTINCT
		  ,1/NUM_DISTINCT DENSITY 
	  FROM USER_TAB_COL_STATISTICS 
	 WHERE TABLE_NAME = 'YOUR_TABLE' 
	   AND COLUMN_NAME = 'YOUR_COLUMN';

2.3 Cardinality estimated value  (tot_rows  *  estimated_ratio)
	SELECT TOT_ROWS * 0.ESTIMATED_RATIO 
      FROM DUAL;

***Part 3:
3.1 SELECT /*+ GATHER_PLAN_STATISTICS */ COUNT(*) 
	  FROM YOUR_TABLE 
	 WHERE YOUR_COLUMN1 = X 
	   AND YOUR_COLUMN2 = Y;
       
	SELECT * 
	  FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(null,null,'ALLSTATS LAST'));

3.2 Get the predictive_selectivity value
	SELECT NUM_DISTINCT 
		 , 1/NUM_DISTINCT DENSITY 
	  FROM USER_TAB_COL_STATISTICS 
	 WHERE TABLE_NAME = 'YOUR_TABLE' 
	   AND COLUMN_NAME = 'YOUR_COLUMN1';

	SELECT NUM_DISTINCT 
		 , 1/NUM_DISTINCT DENSITY 
	  FROM USER_TAB_COL_STATISTICS 
	 WHERE TABLE_NAME = 'YOUR_TABLE' 
	   AND COLUMN_NAME = 'YOUR_COLUMN2';

3.3 Cardinality estimated value (tot_rows  *  estimated_ratio(first predicate)  *  estimated_ratio(second predicate))
	SELECT TOT_ROWS * ESTIMATED_RATIO/*FROM YOUR_COLUMN1*/ * ESTIMATED_RATIO/*FROM YOUR_COLUMN2*/
	  FROM DUAL;

***Part 4:
4.1 Create the table:
	CREATE TABLE MYTABLE_1 AS
		SELECT ROWNUM COL1 
			  ,(ROWNUM * -1) COL2 
			  ,A.*
		  FROM ALL_OBJECTS A;

4.2 Select data from the table:
	SELECT * 
	  FROM MYTABLE_1;

4.3 Generate stats on the table (Table, Column, Histogram):
	EXECUTE DBMS_STATS.GATHER_TABLE_STATS (USER,'MYTABLE_1' , METHOD_OPT => 'for all columns size 254' );

4.4 Check if the statistics are generated or not:
	SELECT * 
	  FROM USER_TAB_STATISTICS 
	 WHERE TABLE_NAME = 'MYTABLE_1';

	SELECT * 
	  FROM USER_TAB_COL_STATISTICS 
	 WHERE TABLE_NAME = 'MYTABLE_1';

4.5 Oracle Estimates the Cardinality for this Arithmetic Expression:
	SELECT /*+ GATHER_PLAN_STATISTICS */ * 
	  FROM MYTABLE_1 WHERE (col1 + col2)/2 > 100; 

	Check the Execution Plan
	SELECT * 
	  FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(null,null,'ALLSTATS LAST'));

4.6 Check the total count and the 5% of total count data:
	SELECT COUNT(*) Total_rows
		  ,COUNT(*) * (5/100) Rows_5_percent  
	  FROM MYTABLE_1;

4.7 Cardinality estimated value (TOT_ROWS * 5%):
	SELECT TOT_ROWS * (0.05) 
	  FROM DUAL;