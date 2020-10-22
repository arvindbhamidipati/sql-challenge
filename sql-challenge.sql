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

-- (1) List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees JOIN salaries
ON employees.emp_no = salaries.emp_no;

-- (2) List first name, last name, and hire date for employees who were hired in 1986.
SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01';
