--Create tables for each of the csv files.
	-- dept_no <-- is a primary key
	-- emp_no <-- is a primary key

CREATE TABLE "departments" ("dept_no" VARCHAR NOT NULL,
							"dept_name" VARCHAR NOT NULL,
							CONSTRAINT "pk_departments" PRIMARY KEY ("dept_no")
							);

CREATE TABLE "dept_emp" ("emp_no" INT NOT NULL,
						 "dept_no" VARCHAR NOT NULL
						);

CREATE TABLE "dept_manager" ("dept_no" VARCHAR NOT NULL,
							 "emp_no" INT NOT NULL
							);

CREATE TABLE "employees" ("emp_no" INT NOT NULL,
						  "emp_title_id" VARCHAR NOT NULL,
						  "birth_date" DATE NOT NULL,
						  "first_name" VARCHAR NOT NULL,
						  "last_name" VARCHAR NOT NULL,
						  "sex" VARCHAR NOT NULL,
						  "hire_date" DATE NOT NULL,
						  CONSTRAINT "pk_employees" PRIMARY KEY ("emp_no")
);

CREATE TABLE "salaries" ("emp_no" INT   NOT NULL,
						 "salary" INT   NOT NULL
						);

CREATE TABLE "titles" ("title_id" VARCHAR NOT NULL,
					   "title" VARCHAR NOT NULL,
					   CONSTRAINT "pk_titles" PRIMARY KEY ("title_id")
					  );

-- Connect the tables

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_titles_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");


-- SELECT * FROM departments;
-- SELECT * FROM dept_emp;
-- SELECT * FROM dept_manager;
-- SELECT * FROM employees;
-- SELECT * FROM salaries;
-- SELECT * FROM titles;

-- (1) List the following details of each employee: employee number, last name, first name, sex, and salary.
	/*
		Join employees and salaries tables to get:
				Table		Column Name
		------------------------------------
			1) employees 	- emp_no
			2) employees 	- last_name
			3) employees 	- first_name
			4) employees 	- sex
			5) salaries  	- salary
	*/

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees JOIN salaries
ON employees.emp_no = salaries.emp_no;

-- (2) List first name, last name, and hire date for employees who were hired in 1986.
	/*
		Information is in employees table
				Table		Column Name
		------------------------------------
			1) employees 	- first_name
			2) employees 	- last_name
			3) employees 	- hire_date

		Filter for the dates you are looking for
	*/

SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01';

-- (3) List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
	/*
		Information is in 3 tables - departments, dept_manager, employees to get:
				Table		    Column Name
		----------------------------------------
			1) departments 	    - dept_no
			2) departments 	    - dept_name
			3) dept_manager 	- emp_no
			4) employees		- last_name
			5) employees		- first_name

			departments -> dept_manager by column = dept_no
			dept_manager -> employees by column = emp_no
	*/



SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;

-- (4) List the department of each employee with the following information: employee number, last name, first name, and department name.
	/*
		Information is in 3 tables - departments, dept_manager, employees to get:
				Table		    Column Name
		----------------------------------------
			1) dept_emp 	    - emp_no
			4) employees		- last_name
			5) employees		- first_name
			5) departments		- dept_name

			dept_emp -> employees by column = emp_n
			dept_emp -> dept_no by column = dept_no
	*/

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

-- (5) List all employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--  (6) List all employees in the Sales department, including their employee number, last name, first name, and department name.
	/*
		Information is in 3 tables - departments, dept_emp, employees to get:
				Table		    Column Name
		----------------------------------------
			1) dept_emp 	    - emp_no
			4) employees		- last_name
			5) employees		- first_name
			5) departments		- dept_name

			dept_emp -> employees by column = emp_no
			dept_emp -> dept_no by column = dept_no

		Apply condition where department name is Sales.
	*/

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- (7) List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
	/*
		Information is in 3 tables - departments, dept_emp, employees to get:
				Table		    Column Name
		----------------------------------------
			1) dept_emp 	    - emp_no
			4) employees		- last_name
			5) employees		- first_name
			5) departments		- dept_name

			dept_emp -> employees by column = emp_no
			dept_emp -> dept_no by column = dept_no

		Apply condition where department name is Sales and add OR since we also want Developement
	*/

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'
OR departments.dept_name = 'Development';

-- (8) In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;
