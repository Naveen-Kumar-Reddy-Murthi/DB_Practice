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
                                                     
--emps having greater sal than any IT_PROG

select * from employees where salary >= any(select salary from employees where job_id='IT_PROG');