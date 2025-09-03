-- Code to print stars in triangle shape
EXECUTE IMMEDIATE $$
DECLARE
    i INTEGER;
    j INTEGER;
    pattern VARCHAR default '';
BEGIN
    FOR i IN 1 TO 5 
    DO
        FOR j IN 1 TO i
        DO
            pattern := pattern || '|\t';
        END FOR;
        pattern := pattern || '\n';
    END FOR;
RETURN pattern;
END;
$$;
-- Find prime numbers upto given number
CREATE OR REPLACE PROCEDURE EMP.PROCS.SP_WHILE_PRIME_NUMBERS("N" INTEGER)
    RETURNS VARCHAR
    LANGUAGE SQL EXECUTE
    AS CALLER
    AS DECLARE i INTEGER default 3;
j INTEGER;
flag INTEGER;
prime VARCHAR default '2 ';
BEGIN WHILE (i <= N) DO flag := 0;
FOR j IN 2 TO i -1 DO IF (i % j = 0) THEN flag := 1;
break;
END IF;
END FOR;
IF (flag = 0) THEN prime := prime || ', ' || i;
END IF;
i := i + 1;
END WHILE;
RETURN prime;
END;
CALL EMP.PROCS.SP_WHILE_PRIME_NUMBERS(1000);
-- Find prime numbers upto given number in the form of a Table.
CREATE OR REPLACE PROCEDURE EMP.PROCS.SP_WHILE_PRIME_NUMBERS("N" INTEGER)
    RETURNS TABLE(PRIME INTEGER)
    LANGUAGE SQL EXECUTE
    AS CALLER
    AS DECLARE i INTEGER default 2;
j INTEGER;
flag INTEGER;
res RESULTSET;
prime VARCHAR;
BEGIN CREATE
    OR REPLACE TEMPORARY TABLE PRIME_NUMBERS(PRIME INTEGER);
WHILE (i <= N) DO flag := 0;
FOR j IN 2 TO i -1 DO IF (
        i % j = 0
        and i <> 2
    ) THEN flag := 1;
break;
END IF;
END FOR;
IF (flag = 0) THEN --prime := prime || ', ' || i;
INSERT INTO
    PRIME_NUMBERS
VALUES(:i);
END IF;
i := i + 1;
END WHILE;
prime := 'SELECT * FROM PRIME_NUMBERS';
res := (EXECUTE IMMEDIATE :prime);
RETURN TABLE(res);
END;
CALL EMP.PROCS.SP_WHILE_PRIME_NUMBERS(100);
create or replace procedure emp.procs.sp_fibonacci_number("N" integer)
    returns table(fibonacci integer)
    language sql
    as declare first integer default 0;
second integer default 1;
next integer;
res resultset;
begin create
    or replace temporary table fib_number(fibonacci integer);
insert into
    fib_number
values
    (:first);
insert into
    fib_number
values
    (:second);
while (first + second <= N) DO next := first + second;
insert into
    fib_number
values(:next);
first := second;
second := next;
END while;
res := (
    select
        *
    from
        fib_number
);
return table(res);
end;
call emp.procs.sp_fibonacci_number(100);
create or replace procedure emp.procs.sp_factorial_numbers("N" integer)
    returns table(number integer, factorial number)
    language sql
    as declare i integer default 1;
fact number default 1;
res resultset;
begin create
    or replace temporary table fact_numbers(number integer, factorial number);
while i <= N do if(i = 1) then fact := 1;
    else fact := fact * i;
end if;
INSERT INTO
    FACT_NUMBERS
VALUES(:i, :fact);
i := i + 1;
END WHILE;
res := (
    SELECT
        *
    FROM
        FACT_NUMBERS
);
RETURN TABLE(res);
end;