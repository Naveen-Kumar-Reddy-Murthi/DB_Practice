create table sal(basic number,hra GENERATED ALWAYS AS(BASIC*3) VIRTUAL);

INSERT INTO SAL(BASIC) VALUES(100);

SELECT * FROM SAL;
SELECT BASIC,BASIC*4,HRA FROM SAL;

SELECT INTERVAL '300' MONTH ,INTERVAL '54-2' YEAR TO MONTH, INTERVAL '11:12:45.123456' HOUR TO SECOND FROM DUAL;

SELECT * FROM EMPLOYEES where hire_date like '%___01%';--EMPLOYESS JOINED ON FIRST NINE DAYS

SELECT * FROM EMPLOYEES where SALARY like '_____';-- EMPS WITH FIVE DIGIT SALARY

SELECT * FROM EMPLOYEES WHERE FIRST_NAME LIKE '%\_%' ESCAPE '\';-- emps having a _ in their first name

SELECT * FROM employees order by first_name nulls first;

--update employees set first_name='naveen' where employee_id=121 returning first_name into :firstname;

SELECT INSTR('NAVEEN','N',2,1) FROM DUAL; 

select replace('naven reddy murthi', 'ee', '*') from dual;

select TRANSLATE('naveen reddy murthi', 'ee', '*') from dual;

select * from employees where soundex('SMITH')=soundex('SMYTH');

SELECT ASCII('ABVVVV') FROM DUAL;

select chr(97) from dual;

select extract(year from hire_Date) hire_year from employees;

select extract(month from hire_Date) hire_year from employees;

select extract(day from hire_Date) hire_year from employees;

select add_months(sysdate,-1) from dual;

select last_day(sysdate) from dual;

select months_between(sysdate, hire_Date) diff, hire_date from employees where first_name like '%naveen%';

select next_day(sysdate,'monday') from dual;

select abs(-10) from dual;

select sign(-100) from dual;

select power(2,3) from dual;

select sqrt(2) from dual;

select mod(101,2) from dual;

select round(3.56) from dual;

select round(sysdate,'year') from dual;

select round(sysdate,'month') from dual;

select round(sysdate,'day') from dual;

select trunc(3.456,3) from dual;

select trunc(sysdate,'year') from dual;

select trunc(sysdate,'month') from dual;

select trunc(sysdate,'day') from dual;

select to_char(hire_Date,'yyyy') from employees;

select to_char(hire_Date,'dy') from employees;

--select to_date(to_char('05-dec-2016','fmDdspth ''of'' Month,Year')) from dual; --tbd

select first_name,salary,nvl(COMMISSION_PCT,0) commission,salary+nvl(COMMISSION_PCT,0) totalSal from employees;

select first_name,salary,nvl2(COMMISSION_PCT,commission_pct,10000) commission,salary+nvl2(COMMISSION_PCT,commission_pct+10000,15000) total
from employees;

select greatest(10,20,30) greatest from dual;

select greatest('A','B','C') greatest from dual;

select greatest('A','a') greatest from dual;

select least(10,20,30) least from dual;

select least('A','B','C') least from dual;

select least('A','a') least from dual;

select nullif(1,-1) from dual;--1

select coalesce(10,1,null) from dual;

select coalesce(null,null,null,NULL,1) from dual;

select trunc(round(156.00,-1),-1) from dual; --160

--GROUP BY ON MULTIPLE COLUMNS

SELECT DEPARTMENT_ID,JOB_ID,SUM(SALARY) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID,JOB_ID ORDER BY DEPARTMENT_ID;

--DEPT WISE AND JOB WISE SALARY SUM

SELECT DEPARTMENT_ID, NVL(SUM(DECODE(JOB_ID,'IT_PROG',SALARY)),0) AS IT_PROG,
                      NVL(SUM(DECODE(JOB_ID,'FI_MGR',SALARY)),0) AS FI_MGR,
                      NVL(SUM(DECODE(JOB_ID,'PU_CLERK',SALARY)),0) AS PU_CLERK,
                      NVL(SUM(DECODE(JOB_ID,'HR_REP',SALARY)),0) AS HR_REP,
                      NVL(SUM(DECODE(JOB_ID,'ST_MAN',SALARY)),0) AS ST_MAN
FROM EMPLOYEES GROUP BY DEPARTMENT_ID ORDER BY DEPARTMENT_ID;

--ABOVE USING PIVOT OPERATOR

SELECT * FROM (SELECT DEPARTMENT_ID, SALARY, JOB_ID FROM EMPLOYEES)
PIVOT
(SUM(SALARY) FOR JOB_ID IN('IT_PROG','FI_MGR','PU_CLERK','HR_REP','ST_MAN') )ORDER BY DEPARTMENT_ID;

--roll up ex

select department_id,sum(salary) from employees group by rollup(department_id) order by department_id;

--multiple columns in roll up
--returns row containing subtotal for each group + a row containing a grand total for all the groups
select department_id,job_id,sum(salary) from employees group by rollup(department_id,job_id) order by department_id;

--cube example
-- returns rows containing a subtotal for all combinations of columns + row containing the grand total
select department_id, sum(salary) from employees group by cube(department_id) order by department_id;

select department_id,job_id,sum(salary) from employees group by cube(department_id,job_id) order by department_id;

--grouping functions. This can be used with rollup or cube
--useful to denote values, if roll up/cube column returns null then grouping returns 1 else zero
select department_id,job_id,sum(salary) as salary, grouping(department_id) group_dept, grouping(job_id) group_job from employees
group by rollup(department_id,job_id) order by department_id;

--grouping_id

select department_id,job_id,sum(salary) as salary, grouping_id(department_id,job_id) from employees
group by cube(department_id,job_id) order by department_id;


