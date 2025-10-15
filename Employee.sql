-- DROP old tables if exist (optional)
DROP TABLE Emps CASCADE CONSTRAINTS;
DROP TABLE Dept CASCADE CONSTRAINTS;

-- DEPARTMENT TABLE
CREATE TABLE Dept (
    Deptno NUMBER PRIMARY KEY,
    Dname VARCHAR2(30) NOT NULL,
    Loc   VARCHAR2(30)
);

-- EMPLOYEE TABLE
CREATE TABLE Emps (
    Empno NUMBER PRIMARY KEY,
    Ename VARCHAR2(30) NOT NULL,
    Job   VARCHAR2(30),
    Sal   NUMBER(10,2),
    Deptno NUMBER,
    CONSTRAINT fk_dept FOREIGN KEY (Deptno) REFERENCES Dept(Deptno)
);

-- Insert Departments
INSERT INTO Dept VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO Dept VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO Dept VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO Dept VALUES (40, 'OPERATIONS', 'BOSTON');
INSERT INTO Dept VALUES (50, 'HR', 'MUMBAI');

-- Insert Employees
INSERT INTO Emps VALUES (1001, 'SMITH', 'CLERK', 1500, 20);
INSERT INTO Emps VALUES (1002, 'ALLEN', 'SALESMAN', 1800, 30);
INSERT INTO Emps VALUES (1003, 'WARD', 'SALESMAN', 1700, 30);
INSERT INTO Emps VALUES (1004, 'JONES', 'MANAGER', 2500, 20);
INSERT INTO Emps VALUES (1005, 'MARTIN', 'SALESMAN', 1600, 30);
INSERT INTO Emps VALUES (1006, 'BLAKE', 'MANAGER', 2850, 30);
INSERT INTO Emps VALUES (1007, 'CLARK', 'MANAGER', 2450, 10);
INSERT INTO Emps VALUES (1008, 'KING', 'PRESIDENT', 5000, 10);
INSERT INTO Emps VALUES (1009, 'FORD', 'ANALYST', 3000, 20);
INSERT INTO Emps VALUES (1010, 'SCOTT', 'ANALYST', 3000, 20);

--a. Display employee names along with their department names

SELECT e.Ename, d.Dname
FROM Emps e
JOIN Dept d ON e.Deptno = d.Deptno;


---

--b. List all employees with their job titles and the location of their department

SELECT e.Ename, e.Job, d.Loc
FROM Emps e
JOIN Dept d ON e.Deptno = d.Deptno;


---

--c. Display employees who work in the SALES department

SELECT e.Ename, e.Job, d.Dname
FROM Emps e
JOIN Dept d ON e.Deptno = d.Deptno
WHERE d.Dname = 'SALES';


---

--d. List all employees with their department name and location, including departments with no employees

SELECT e.Ename, d.Dname, d.Loc
FROM Dept d
LEFT JOIN Emps e ON e.Deptno = d.Deptno;


---

--e. Display all departments and employees, even if some employees are not assigned to any department

SELECT e.Ename, d.Dname
FROM Emps e
FULL OUTER JOIN Dept d ON e.Deptno = d.Deptno;


---

--f. Show each department name and total salary paid to its employees

SELECT d.Dname, SUM(e.Sal) AS Total_Salary
FROM Dept d
JOIN Emps e ON d.Deptno = e.Deptno
GROUP BY d.Dname;


---

--g. Find departments that have more than 3 employees

Display department name and employee count.

SELECT d.Dname, COUNT(e.Empno) AS Num_Employees
FROM Dept d
JOIN Emps e ON d.Deptno = e.Deptno
GROUP BY d.Dname
HAVING COUNT(e.Empno) > 3;


---

--h. Display employees who work in the same location as the ACCOUNTING department

SELECT Ename
FROM Emps
WHERE Deptno IN (
    SELECT Deptno FROM Dept
    WHERE Loc = (SELECT Loc FROM Dept WHERE Dname = 'ACCOUNTING')
);


---

--i. For each department, display the employee who has the highest salary

SELECT e.Ename, e.Sal, d.Dname
FROM Emps e
JOIN Dept d ON e.Deptno = d.Deptno
WHERE e.Sal = (
    SELECT MAX(Sal)
    FROM Emps
    WHERE Deptno = e.Deptno
);


---

--j. List employees whose salary is greater than the average salary of their department

SELECT e.Ename, e.Sal, d.Dname
FROM Emps e
JOIN Dept d ON e.Deptno = d.Deptno
WHERE e.Sal > (
    SELECT AVG(Sal)
    FROM Emps
    WHERE Deptno = e.Deptno
);
