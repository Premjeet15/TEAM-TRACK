/*1.	Create a database named employee, then import data_science_team.csv 
proj_table.csv and emp_record_table.csv into the employee database from the given resources.*/
CREATE DATABASE IF NOT EXISTS EMPLOYEE;
USE EMPLOYEE;
SELECT * FROM data_science_team;
SELECT * FROM emp_record_table;
SELECT * FROM proj_table;


/*3.	Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department.*/
CREATE DATABASE IF NOT EXISTS EMPLOYEE_1;
USE EMPLOYEE_1;
SELECT EMP_ID, CONCAT(FIRST_NAME, '',LAST_NAME) AS EMPLOYEES, GENDER, DEPT
FROM emp_record_table; 


/*4.	Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
●	less than two
●	greater than four 
●	between two and four*/
CREATE DATABASE IF NOT EXISTS EMPLOYEE_2;
USE EMPLOYEE_2;
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING < 2;
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING > 4;
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING BETWEEN 2 AND 4;


/*5.	Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME.*/
CREATE DATABASE IF NOT EXISTS EMPLOYEE_3;
USE EMPLOYEE_3;
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME, DEPT
FROM emp_record_table
WHERE DEPT = 'FINANCE';


/*6.	Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).*/
CREATE DATABASE IF NOT EXISTS EMPLOYEE_4;
USE EMPLOYEE_4;
   
SELECT e1.manager_id, 
       count(*)
FROM emp_record_table  e1,
     emp_record_table  e2
WHERE e1.manager_id = e2.emp_id
GROUP BY e1.manager_id 
ORDER BY e1.manager_id ASC;


/*7.	Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table.*/
CREATE DATABASE IF NOT EXISTS EMPLOYEE_5;
USE EMPLOYEE_5;
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME, DEPT
FROM emp_record_table
WHERE DEPT = 'FINANCE'

UNION

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME, DEPT
FROM emp_record_table
WHERE DEPT = 'HEALTHCARE';


/*8.	Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department.*/
CREATE DATABASE IF NOT EXISTS EMPLOYEE_6;
USE EMPLOYEE_6;
SELECT MAX(EMP_RATING)AS MAX_EMP_RATING_DEPT, DEPT
FROM emp_record_table
GROUP BY DEPT;


/*9.	Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.*/
CREATE DATABASE IF NOT EXISTS EMPLOYEE_7;
USE EMPLOYEE_7;
SELECT ROLE,
       MIN(SALARY) AS MIN_SALARY,
       MAX(SALARY) AS MAX_SALARY
FROM emp_record_table
GROUP BY ROLE;


/*10.	Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.*/
CREATE DATABASE IF NOT EXISTS EMPLOYEE_8;
USE EMPLOYEE_8;
SELECT EMP_ID, CONCAT(FIRST_NAME,'',LAST_NAME) AS NAME, EXP,
DENSE_RANK() OVER (ORDER BY EXP DESC) AS EXP_RANK
FROM emp_record_table;


/*11.	Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table.*/
CREATE DATABASE IF NOT EXISTS EMPLOYEE_9;
USE EMPLOYEE_9;
SELECT EMP_ID, CONCAT(FIRST_NAME,'',LAST_NAME) AS EMP_NAME, COUNTRY, SALARY
FROM emp_record_table
GROUP BY EMP_ID, EMP_NAME, COUNTRY,SALARY
HAVING salary > 6000;


/*12.	Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.*/
CREATE DATABASE IF NOT EXISTS EMPLOYEE_9;
USE EMPLOYEE_9;
SELECT EMP_ID, CONCAT(FIRST_NAME,'',LAST_NAME) AS EMP_NAME, COUNTRY, SALARY
FROM emp_record_table
GROUP BY EMP_ID, EMP_NAME, COUNTRY,SALARY
HAVING salary > 6000;


/*13.	Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.*/
CREATE DATABASE IF NOT EXISTS EMPLOYEE_11;
USE EMPLOYEE_11;
DELIMITER //

CREATE PROCEDURE GET_EMPLOYEES_WITH_MORE_THAN_THREE_YEARS_EXPERIENCE()
BEGIN
    SELECT *
    FROM emp_record_table
    WHERE EXP > 3;
END //

DELIMITER ;
CALL GET_EMPLOYEES_WITH_MORE_THAN_THREE_YEARS_EXPERIENCE();


/*14.	Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.
The standard being:
For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
For an employee with the experience of 12 to 16 years assign 'MANAGER'.*/
CREATE DATABASE IF NOT EXISTS EMPLOYEE_12;
USE EMPLOYEE_12;
DELIMITER //
Create Function Org_Exp_Std( exp_year int)
Returns Varchar(25)
Deterministic
Begin
    Declare role_found varchar(25);
    If  exp_year <=2  Then
		Select distinct role into role_found from emp_record_table where exp =exp_year;
    Elseif (exp_year >2 And exp_year<=5) Then
		Select distinct role into role_found from emp_record_table where exp =exp_year;
	Elseif (exp_year >5 And exp_year<=10) Then
		Select distinct role into role_found from emp_record_table where exp =exp_year;
	Elseif (exp_year >10 And exp_year<=12) Then
		Select distinct role into role_found from emp_record_table where exp =exp_year;
	Elseif (exp_year >12 And exp_year<=16) Then
		Select distinct role into role_found from emp_record_table where exp =exp_year;
	End If;
    Return (role_found);
End //

DELIMITER $$

Create Index F_Name_INDX on emp_record_table(First_name(30));

Select salary,emp_rating, round(((5 * Salary * Emp_rating)/100),2) as Bonus from emp_record_table;

select salary, round(avg(salary),2) as avg_salary,country,continent  from emp_record_table group by CONTINENT, COUNTRY;


/*15.	Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.*/
CREATE DATABASE IF NOT EXISTS EMPLOYEE_13;
USE EMPLOYEE_13;
SELECT * FROM  emp_record_table WHERE FIRST_NAME = 'Eric';


/*16.	Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).*/
CREATE DATABASE IF NOT EXISTS EMPLOYEE_14;
USE EMPLOYEE_14;
SELECT
EMP_ID,
CONCAT(FIRST_NAME ,'   ', LAST_NAME) AS EMP_NAME,
SALARY,
EMP_RATING,
((5/100* SALARY) * EMP_RATING) AS BONUS
FROM emp_record_table;


/*17.	Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.*/
CREATE DATABASE IF NOT EXISTS EMPLOYEE_15;
USE EMPLOYEE_15;
SELECT 
EMP_ID,
CONCAT(FIRST_NAME,'  ',LAST_NAME) AS EMP_NAME,
    CONTINENT,
    COUNTRY,
    AVG(SALARY) AS AVG_SALARY
FROM 
    emp_record_table
GROUP BY 
    EMP_NAME, EMP_ID, CONTINENT, COUNTRY;

