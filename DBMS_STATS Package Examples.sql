In this section, we explore SQL and PL/SQL commands for generating and inspecting table, column, histogram, and index statistics, as well as system statistics in the SYS schema.

***Part 1: Table, Column, and Histogram Statistics
1.1 Generate Table, Column, and Histogram Statistics
    EXECUTE DBMS_STATS.GATHER_TABLE_STATS (OWNNAME          => 'OWNER_NAME'
                                         , TABNAME          => 'TABLE_NAME'
                                         , ESTIMATE_PERCENT => DBMS_STATS.AUTO_SAMPLE_SIZE
                                         , METHOD_OPT       => 'for all columns size auto');

This PL/SQL command generates comprehensive statistics for a specific table ('TABLE_NAME') in the OWNER_NAME schema, including statistics for all columns and histograms.

1.2 Check Table Statistics
    SELECT *
      FROM USER_TAB_STATISTICS 
     WHERE TABLE_NAME = 'TABLE_NAME' AND OBJECT_TYPE = 'TABLE';

This SQL query retrieves and displays the table statistics for a specific table ('TABLE_NAME') from the USER_TAB_STATISTICS view.

1.3 Check Column and Histogram Statistics
    SELECT * 
      FROM USER_TAB_COL_STATISTICS 
     WHERE TABLE_NAME = 'TABLE_NAME';

This SQL query retrieves and displays column and histogram statistics for a specific table ('TABLE_NAME') from the USER_TAB_COL_STATISTICS view.

***Part 2: Index Statistics
2.1 Generate Index Statistics
    EXECUTE DBMS_STATS.GATHER_INDEX_STATS (OWNNAME          => 'OWNER_NAME'
                                         , INDNAME          => 'INDEX_NAME'
                                         , ESTIMATE_PERCENT => DBMS_STATS.AUTO_SAMPLE_SIZE);

This PL/SQL command generates statistics for a specific index ('INDEX_NAME') in the OWNER_NAME schema, providing insights into its performance characteristics.

2.2 Check Index Statistics
    SELECT * 
      FROM USER_IND_STATISTICS 
     WHERE TABLE_NAME = 'TABLE_NAME' 
       AND OBJECT_TYPE = 'INDEX';

This SQL query retrieves and displays index statistics for a specific table ('TABLE_NAME') from the USER_IND_STATISTICS view.

***Part 3: System Statistics in SYS Schema
3.1 Manually Start and Stop System Activity Sampling
    EXECUTE DBMS_STATS.GATHER_SYSTEM_STATS('start');
    EXECUTE DBMS_STATS.GATHER_SYSTEM_STATS('stop');

These PL/SQL commands manually initiate and conclude the sampling of representative system activity over several hours.

3.2 Sample System Activity for a Specific Interval
    EXECUTE DBMS_STATS.GATHER_SYSTEM_STATS('interval'
                                         , INTERVAL => X_MINUTES);

This PL/SQL command samples system activity for a specified interval of minutes.

3.3 Check System Statistics
    SELECT PNAME
         , PVAL1 
      FROM SYS.AUX_STATS$;

This SQL query retrieves and displays system-level statistics from the SYS schema, providing valuable information about various parameters influencing the overall performance of the Oracle database.

These commands are essential for database administrators and analysts to comprehensively understand and optimize the performance of specific tables, indexes, and the overall system in an Oracle database.