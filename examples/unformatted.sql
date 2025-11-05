-- Example 1: Simple SELECT (unformatted)
select employee_id,first_name,last_name,email,salary from employees where department_id=10 and status='ACTIVE' order by last_name;

-- Example 2: JOIN query (unformatted)
select e.employee_id,e.first_name,e.last_name,d.department_name,j.job_title from employees e join departments d on e.department_id=d.department_id join jobs j on e.job_id=j.job_id where e.status='ACTIVE' and e.salary>50000;

-- Example 3: INSERT (unformatted)
insert into employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,department_id)values(1001,'John','Doe','john.doe@example.com','555-0100',sysdate,'IT_PROG',75000,60);

-- Example 4: UPDATE (unformatted)
update employees set salary=salary*1.1,last_modified=sysdate where department_id=10 and performance_rating>=4 and hire_date<add_months(sysdate,-12);

-- Example 5: CASE expression (unformatted)
select employee_id,first_name,last_name,salary,case when salary<50000 then 'Low' when salary between 50000 and 100000 then 'Medium' when salary>100000 then 'High' else 'Unknown' end as salary_grade from employees;

-- Example 6: CTE (unformatted)
with dept_avg as(select department_id,avg(salary)as avg_salary from employees where status='ACTIVE' group by department_id)select e.employee_id,e.first_name,e.last_name,e.salary,d.avg_salary from employees e join dept_avg d on e.department_id=d.department_id where e.salary>d.avg_salary;
