In this document, we explore SQL commands to inspect and analyze table statistics in the SH schema and system statistics in the SYS schema.

Part 1: Table Statistics
1.1 Check the table statistics
    SELECT * 
      FROM USER_TAB_STATISTICS 
     WHERE TABLE_NAME = 'TABLE_NAME' 
       AND OBJECT_TYPE = 'TABLE';

1.2 Check the Column and Histogram Statistics
    SELECT * 
      FROM USER_TAB_COL_STATISTICS 
     WHERE TABLE_NAME = 'TABLE_NAME';

1.3 Check the Histogram Details
    SELECT * 
      FROM USER_TAB_HISTOGRAMS 
     WHERE TABLE_NAME = 'TABLE_NAME';

1.4 Check the index statistics
    SELECT * 
      FROM USER_IND_STATISTICS 
     WHERE TABLE_NAME = 'TABLE_NAME' 
       AND OBJECT_TYPE = 'INDEX';

Part 2: System Statistics in SYS Schema
2.1 Check the System Statistics
    SELECT pname
         , pval1 
      FROM sys.aux_stats$;

This query retrieves system-level statistics from the SYS schema, providing information about various parameters that contribute to the overall performance of the Oracle database.

These commands are crucial for database administrators and analysts seeking to understand and optimize the performance of specific tables and the overall system in an Oracle database.