-- Listing the employee number, last and first name of employee and sex. The bulk of the data is stored within the employee table
-- In order to get data from other tables we will have to do a join, and to make things cleaner and organized we will state the
-- the table name first followed by a period and column name.
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
-- To make things even cleaner we will use an alias instead of writing each table name
from employees e
-- To get the salary we will need to reference the two tables to something that makes each employee unique based on their salary
-- we will do a join to the employee number as that is the column that both tables have in common.
inner join salaries s on e.emp_no = s.emp_no;


-- Since all of the data is stored within the employee table we will do a basic query to extract and list the information
select first_name, last_name, hire_date
from employees
-- If we are doing the whole year of 1986, we will do a date range from the first day of the year to the last day of the year.
-- An alternative in getting this range is "">= '1986-01-01' and hire_date <= '1986-12-31'"" a bit more to take in compared to 
-- typing between & and
where hire_date between '1986-01-01' and '1986-12-31';

-- Listing all the variables we want to view.
select dm.emp_no, d.dept_no, d.dept_name, e.first_name, e.last_name, e.emp_no
from dept_manager dm
-- Here we are joining two tables at a time, we will be joining the two tables with the dept_manager table
-- this is because we are already referencing the dept_manager using the from statement. 
inner join employees e on e.emp_no = dm.emp_no
-- Ran into a problem saying that dept_no doesn't exist within the dept_manager table..
-- SOLUTION the dept_manager table the dept_no is spelled as 'dept_num'. For future references
inner join departments d on d.dept_no = dm.dept_num;

select e.first_name, e.last_name, e.emp_no, d.dept_no, d.dept_name
from dept_emp de
inner join departments d on d.dept_no = de.dept_no
inner join employees e on e.emp_no = de.emp_no;

-- Since we are only choosing variables from one table we don't have to create an alias, though we can but it won't look as clean
-- compared to just stating the columns.
select first_name, last_name, sex
from employees
-- Ran into a problem saying that B is not a column.
-- SOLUTION used double quoatations vs single. Changed to single quotes.
-- NOTE the B will be the beggining letter and the % is used as being a placeholder for the letters followed by B
-- The % will then be replaced by the following letters to complete the last name.
where first_name = 'Hercules' and last_name like 'B%';

-- Similar to the codes above instead this time we are including the where statement.
select e.emp_no, e.first_name, e.last_name, d.dept_name
from employees e
inner join dept_emp de on de.emp_no = e.emp_no
inner join departments d on d.dept_no = de.dept_no
where d.dept_name = 'Sales';


select e.emp_no, e.first_name, e.last_name, d.dept_name
from employees e
inner join dept_emp de on de.emp_no = e.emp_no
inner join departments d on d.dept_no = de.dept_no
-- Only difference in this block of code is that we are using in instead of on since we are looking at one column and specifying
-- more than one value.
where d.dept_name in ('Sales', 'Development'); 
-- To sort the results use >> order by d.dept_name.
-- When sorting you may need to scroll down to x amount to see a different value other than development
-- For this case I will not be sorting the values so I don't have to scroll down until I verify and see a sales employee

-- Here we want to know how many times each last names occur within the hired employees. To do this we first select the last names
-- column and count how rows have values and we are going to give it an alias
select last_name, count(last_name) as "Last Name Count"
from employees
-- We then want to group them by their last name. This makes the occuring last names show up once compared to showing up more than once
-- We are also doing a group  so that we can count the number of employees who share each last name
group by last_name
order by "Last Name Count" desc;