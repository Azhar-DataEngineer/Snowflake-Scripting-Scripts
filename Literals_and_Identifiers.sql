SET
    DB = 'EMP';
SET
    TBL_SCHEMA = 'HRDATA';
SET
    PROC_SCHEMA = 'PROCS';
USE DATABASE $DB;
-- Not Correct
    USE DATABASE IDENTIFIER($DB);
-- Correct
    CREATE SCHEMA IF NOT EXISTS $PROC_SCHEMA;
-- Not Correct
    CREATE SCHEMA IF NOT EXISTS ($PROC_SCHEMA);
-- Not Correct
    CREATE SCHEMA IF NOT EXISTS IDENTIFIER($PROC_SCHEMA);
-- Correct
    CREATE SCHEMA IF NOT EXISTS IDENTIFIER($TBL_SCHEMA);
USE SCHEMA IDENTIFIER($PROC_SCHEMA);
-- Procedure to return the row counts of 4 tables in EMP database.
CREATE OR REPLACE PROCEDURE EMP.PROCS.SP_LITERALS_IDENTIFIERS_DEMO("DBNAME" VARCHAR)
    RETURNS VARCHAR
    LANGUAGE SQL COMMENT = 'Demo Program on Literals and Identifiers' EXECUTE
    AS CALLER
    AS DECLARE table1 VARCHAR;
table2 VARCHAR default 'departments';
dept INTEGER;
empl INTEGER;
cntry INTEGER;
loc INTEGER;
BEGIN table1 := 'employees';
LET table3 := 'countries';
--one way to set the variable in the BEGIN section
    LET TBL_SCHEMA := 'HRDATA';
USE DATABASE IDENTIFIER(:DBNAME);
---
    USE SCHEMA IDENTIFIER(:TBL_SCHEMA);
---
SELECT
    COUNT(*) into :empl
FROM
    TABLE(:table1);
--- table literal
SELECT
    COUNT(*) into :dept
FROM
    IDENTIFIER(:table2);
---identifiers
SELECT
    COUNT(*) into :cntry
FROM
    TABLE(:table3);
---table literal
SELECT
    COUNT(*) into :loc
FROM
    IDENTIFIER('emp.hrdata.locations');
---example for string literals
    RETURN 'employees count ' || empl || ', departments count ' || dept || ', countries count ' || cntry || ', locations count ' || loc;
END;
CALL EMP.PROCS.SP_LITERALS_IDENTIFIERS_DEMO('EMP');
-- Creating my procedure
create or replace procedure emp.procs.all_table_stats("DBNAME" VARCHAR)
    returns VARCHAR
    language SQL comment = 'Demo procedure' execute
    as caller
    as declare table1 VARCHAR;
table2 VARCHAR default 'countries';
empl INTEGER;
countries INTEGER;
jobs INTEGER;
begin table1 := 'employees';
LET table3 := 'jobs';
LET schema := 'hrdata';
use database identifier(:DBNAME);
use schema identifier(:schema);
select
    count(1) into :empl
from
    table(:table1);
select
    count(1) into :countries
from
    identifier(:table2);
select
    count(1) into :jobs
from
    identifier(:table3);
return 'Employees table count: ' || empl;
end;
call emp.procs.all_table_stats('emp')