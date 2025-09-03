-- Variable Declaration and Assignment
EXECUTE IMMEDIATE $$
    DECLARE
        First_Name VARCHAR default 'This is';
		Last_Name VARCHAR;
		Full_Name STRING;
    BEGIN
        LET Middle_Name := ' ';
        Last_Name := 'Snowflake Scripting';
		
		-- Full_Name := First_Name || Middle_Name || Last_Name;        
		SELECT :First_Name || :Middle_Name || :Last_Name into :Full_Name;
        
		RETURN Full_Name;
    END;
$$;
EXECUTE IMMEDIATE $$
    DECLARE
        Base_Salary NUMBER default 50000;
        Bonus_Percentage NUMBER;
        Years_Experience NUMBER default 3;
        Total_Compensation NUMBER;
    BEGIN
        -- Calculate bonus percentage based on experience
        -- 0-2 years: 5%, 3-5 years: 10%, 6+ years: 15%

        
        
        -- Calculate total compensation
        -- Return the result
    END;
$$ execute immediate $$
    DECLARE

$$;
EXECUTE IMMEDIATE $$
    DECLARE
        profit number(38, 2) DEFAULT 0.0;
    BEGIN
        LET cost number(38, 2) := 100.0;
        LET revenue number(38, 2) DEFAULT 110.0;

        -- profit := revenue - cost;
        SELECT :revenue - :cost into :profit;
        
        RETURN profit;
    END;
$$;
-- Session Level Variables
SET
    A = 60;
SET
    (B, C) = (220, 10);
SET
    Age = 'My Age is ';
EXECUTE IMMEDIATE $$
    DECLARE
        D Integer;
        
    BEGIN
        D := ($A + $B) / $C;        
		RETURN $Age || D; 
    END;
$$;
SET
    (A, B, place) = (36, 52, 'Mumbai');
EXECUTE IMMEDIATE $$
    BEGIN
    RETURN $place || ' - ' || ($A+$B);
    
    END;
$$;
-- Session Variables can't be modified
SET
    A = 60;
EXECUTE IMMEDIATE $$
    BEGIN
        A := 100;
        --$A := 100;
		RETURN $A;
    END;
$$;