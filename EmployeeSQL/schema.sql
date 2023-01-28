-- Create Employees table
CREATE TABLE "Employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(10)   NOT NULL,
    "birth_date" VARCHAR(10)   NOT NULL,
    "first_name" VARCHAR(50)   NOT NULL,
    "last_name" VARCHAR(50)   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
    "hire_date" VARCHAR(10)   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

-- Create Departments table
CREATE TABLE "Departments" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "dept_name" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

-- Create Titles table
CREATE TABLE "Titles" (
    "title_ID" VARCHAR(10)   NOT NULL,
    "title" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_ID"
     )
);

-- Create Salaries table
CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
	PRIMARY KEY (emp_no)
);

-- Create Department Employees table
CREATE TABLE "Deptmartment_Employees" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(10)   NOT NULL,
	PRIMARY KEY (dept_no, emp_no)
);

-- Create Department Managers table
CREATE TABLE "Department_Managers" (
	"dept_no" VARCHAR(10)   NOT NULL,
    "emp_no" INT   NOT NULL,
	PRIMARY KEY (dept_no, emp_no)
);

-- Alter Employees table to allocate primary key reference
ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_ID");

-- Alter Salaries table to allocate primary key reference
ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

-- Alter Department Employees table to allocate primary key reference
ALTER TABLE "Deptmartment_Employees" ADD CONSTRAINT "fk_Deptmartment_Employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Deptmartment_Employees" ADD CONSTRAINT "fk_Deptmartment_Employees_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

-- Alter Department Managers table to allocate primary key reference
ALTER TABLE "Department_Managers" ADD CONSTRAINT "fk_Department_Managers_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Department_Managers" ADD CONSTRAINT "fk_Department_Managers_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

-- Change string to date format in Employees table
ALTER TABLE "Employees"
ALTER COLUMN birth_date
TYPE date USING to_date(birth_date, 'MM-DD-YYYY');

ALTER TABLE "Employees"
ALTER COLUMN hire_date
TYPE date USING to_date(hire_date, 'MM-DD-YYYY');

-- Check tables have been created with correct headers
SELECT * FROM "Departments"
SELECT * FROM "Department_Managers"
SELECT * FROM "Deptmartment_Employees"
SELECT * FROM "Employees"
SELECT * FROM "Salaries"
SELECT * FROM "Titles"

-- Import CSV's
-- Recheck tables to ensure data imported OK
SELECT * FROM "Departments"
SELECT * FROM "Department_Managers"
SELECT * FROM "Deptmartment_Employees"
SELECT * FROM "Employees"
SELECT * FROM "Salaries"
SELECT * FROM "Titles"

-- List the employee number, last name, first name, sex, and salary of each employee.
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Employees".sex, "Salaries".salary
FROM "Employees"
INNER JOIN "Salaries" ON ("Employees".emp_no = "Salaries".emp_no);

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM "Employees"
WHERE "hire_date" >= '1986-01-01' AND "hire_date" < '1987-01-01';

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Employees".sex, "Departments".dept_no, "Departments".dept_name
FROM "Departments"
INNER JOIN "Department_Managers" ON ("Departments".dept_no = "Department_Managers".dept_no)
INNER JOIN "Employees" ON ("Department_Managers".emp_no = "Employees".emp_no);

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Employees".sex, "Departments".dept_no, "Departments".dept_name
FROM "Departments"
INNER JOIN "Deptmartment_Employees" ON ("Departments".dept_no = "Deptmartment_Employees".dept_no)
INNER JOIN "Employees" ON ("Deptmartment_Employees".emp_no = "Employees".emp_no);

-- List the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
-- something is wrong with the where statement here
SELECT first_name, last_name, sex
FROM "Employees"
WHERE "first_name" = 'Hercules';
-- AND "last_name" = 'B%'

-- List each employee in the Sales department, including their employee number, last name, and first name
-- do I need a 2nd inner join to departments table to find the department or is below OK?
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name
FROM "Employees"
INNER JOIN "Deptmartment_Employees" ON ("Employees".emp_no = "Deptmartment_Employees".emp_no)
WHERE "dept_no" = 'd007';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).