Assignment 1: Calculate Simple Interest

SET SERVEROUTPUT ON;

DECLARE
    p NUMBER := 5000;     -- Principal
    r NUMBER := 5;        -- Rate of Interest
    t NUMBER := 2;        -- Time in years
    si NUMBER;
BEGIN
    si := (p * r * t) / 100;
    DBMS_OUTPUT.PUT_LINE('Simple Interest = ' || si);
END;
/


---

Assignment 2: Employee Bonus Calculation

SET SERVEROUTPUT ON;

DECLARE
    emp_name VARCHAR2(50) := 'John Doe';
    salary NUMBER := 60000;
    bonus NUMBER;
BEGIN
    IF salary > 50000 THEN
        bonus := 0.10 * salary;
    ELSE
        bonus := 0.15 * salary;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_name);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || salary);
    DBMS_OUTPUT.PUT_LINE('Bonus: ' || bonus);
END;
/


---

Assignment 3: Retrieve and Display Department Details

SET SERVEROUTPUT ON;

DECLARE
    v_dept DEPARTMENTS%ROWTYPE;
    v_dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE := 10;  -- Example Department ID
BEGIN
    SELECT * INTO v_dept
    FROM DEPARTMENTS
    WHERE DEPARTMENT_ID = v_dept_id;

    DBMS_OUTPUT.PUT_LINE('Department Name: ' || v_dept.DEPARTMENT_NAME);
    DBMS_OUTPUT.PUT_LINE('Location ID: ' || v_dept.LOCATION_ID);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No department found with ID ' || v_dept_id);
END;
/

> 💡 Ensure you have a DEPARTMENTS table with columns DEPARTMENT_ID, DEPARTMENT_NAME, and LOCATION_ID.




---

Assignment 4: Student Marks Management (Associative Array)

SET SERVEROUTPUT ON;

DECLARE
    TYPE marks_table IS TABLE OF NUMBER INDEX BY VARCHAR2(30);
    student_marks marks_table;

    v_student VARCHAR2(30);
    total NUMBER := 0;
    count NUMBER := 0;
BEGIN
    -- Insert marks
    student_marks('Ravi') := 85;
    student_marks('Sita') := 92;
    student_marks('Anil') := 78;
    student_marks('Geeta') := 88;
    student_marks('Kiran') := 95;

    -- Display all student names with marks
    v_student := student_marks.FIRST;
    WHILE v_student IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE(v_student || ' -> ' || student_marks(v_student));
        total := total + student_marks(v_student);
        count := count + 1;
        v_student := student_marks.NEXT(v_student);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('---------------------------');
    DBMS_OUTPUT.PUT_LINE('Total Marks: ' || total);
    DBMS_OUTPUT.PUT_LINE('Average Marks: ' || (total / count));
END;
/


---

Assignment 5: Country–Capital Lookup

SET SERVEROUTPUT ON;

DECLARE
    TYPE country_capital_table IS TABLE OF VARCHAR2(50) INDEX BY VARCHAR2(50);
    country_capitals country_capital_table;
    country VARCHAR2(50);
BEGIN
    -- Insert country-capital pairs
    country_capitals('India') := 'New Delhi';
    country_capitals('USA') := 'Washington D.C.';
    country_capitals('France') := 'Paris';
    country_capitals('Japan') := 'Tokyo';
    country_capitals('Germany') := 'Berlin';
    country_capitals('Italy') := 'Rome';

    -- Get user input
    country := '&country';  -- substitution variable in SQL*Plus

    -- Display result
    IF country_capitals.EXISTS(country) THEN
        DBMS_OUTPUT.PUT_LINE('Capital of ' || country || ' is ' || country_capitals(country));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Country not found');
    END IF;
END;
/
