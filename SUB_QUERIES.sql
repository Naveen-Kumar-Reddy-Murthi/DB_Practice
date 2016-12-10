-- SUB QUERIES --
-- emps earning sal between min sal of dept 10 and max sal of dept 20

select * from employees where salary between(select min(salary) from employees where department_id=10)
and (select max(salary) from employees where department_id=20);

select department_id from employees group by department_id 
having  avg(salary)>(select  avg(salary) from employees where department_id=10);

select * from employees where employee_id in(100,101);
--100	naveen reddy murthi	King	SKING	515.123.4567	17-06-03	AD_PRES	24000			90
--101	Neena	Kochhar	NKOCHHAR	515.123.4568	21-09-05	AD_VP	17000		100	90

 
update employees set salary=decode(employee_id,100,(select salary from employees where employee_id=101),
                                               101,(select salary from employees where employee_id=100));

--4th,7th,11th,13th records in employee table
select * from employees where rowid in(select decode(rownum,4,rowid,
                                                     7,rowid,
                                                     11,rowid,
                                                     13,rowid) from employees);
                                                     
--emps having greater sal than any AD_PRES

select * from employees where salary > any(select salary from employees where job_id='AD_PRES');

--emps having greater sal than all AD_PRES
select * from employees where salary > all(select salary from employees where job_id='AD_PRES');


--NESTED QUERIES--

--EMPS earning second max salary
select max(salary) from employees;
select * from employees where salary=(select max(salary) from employees where salary<(select max(salary) from employees));
--emps earning max salaries in their departments
select * from employees where (department_id,salary)  in(select department_id,max(salary) from employees group by department_id) 
order by department_id;


--CORELATED QUERIES--

--emps earning more sal than avg salary in their department

select * from employees e where salary>(select avg(salary) from employees where department_id=e.department_id);

--emps earning more than thier managers

select * from employees e where salary>(select salary from employees m where employee_id=e.manager_id);

--select duplicate records from table

select * from employees e where rowid>(select min(rowid) from employees
where employee_id=e.employee_id and first_name=e.first_name and salary=e.salary);

--top 3 max salaries 

select distinct salary from employees a
where 3>(select count(distinct salary) from employees b where a.salary<b.salary);

--exists example
-- select non empty department

select * from departments d where exists(select * from employees where department_id=d.department_id);

-- select empty department

select * from departments d where not exists(select * from employees where department_id=d.department_id);