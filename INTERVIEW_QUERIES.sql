--select emps who's name's first and last letters are same

select * from employees where substr(first_name,1,1)=substr(first_name,-1,1);

--emps who's name contains 'S'

select * from employees where instr(first_name,'n',1,1) <> 0;

-- mnreddy.nv@gmai.com from this display only the first part

select substr('mnreddy.nv@gmai.com',1,instr(' mnreddy.nv@gmai.com','@',1,1)-2) from dual;

-- select records those contain three parts in their name

select * from employees where instr(first_name,' ',1,2)>0;

-- display firstname,salary and in salary column display **** instead of actual values

select first_name,rpad('*',salary/1000,'*') salary from employees;

-- dispaly emps who's firstname contains exactly one 'a'

select * from employees where length(first_name)-length(replace(first_name,'A',''))=1;

--select first 3 letters of emp+hireday(ddmmyy)

select upper(substr(first_name,1,3)||replace(hire_date,'-','')) user_code from employees;

--select emps who joined in first 15 days of apr,dec and in the year bw 1980 1987

select * from employees where extract(day from hire_Date)<=15 and extract(month from hire_Date) in (4,12)
and extract (year from hire_Date) between 2000 and 2006;

--select empss retirementdate and other deatails. Assume retirement is 30 years after hire_Date

select first_name,hire_Date,add_months(hire_Date,30*12) retirement_date from employees where rownum<=10;

--first day of current month

select last_day(sysdate)-30 fist_day_of_month from dual;

select add_months(last_day(sysdate)+1,-1) from dual;

--employess earning salary multiples of 50

select first_name,salary from employees where mod(salary,50)=0;

--emps joined in 2006

select * from employees where to_char(hire_Date,'yyyy')=2006;

--emps joined between jan and april

select * from employees where to_char(hire_Date,'mm') between 1 and 4;

--emps joined on sunday

select to_char(hire_date,'dy') joining_day, first_name,hire_Date from employees where to_char(hire_date,'dy')='sun';

--emps joined day

select first_name,to_char(hire_Date,'day') first_Day from employees;

select to_char(sysdate,'Day,DD-MM-YYYY, HH:MI:SS PM') FROM DUAL;

--SALARY IN WORDS

select first_name,to_char(to_date(salary,'j'),'JSP') from employees;

--total salary paid till date to employees

select round(round(sysdate-hire_date)/365)*12*salary totla_com from employees;

--dept wise total salary paid

select sum(decode(department_id,60,salary)) dept_90,
       sum(decode(department_id,100,salary)) dept_100
from employees;

select department_id,sum(salary) from employees group by department_id;

--emps joined 2000,2001,2002,2003

select count(decode(TO_CHAR(HIRE_dATE,'YYYY'),2001,EMPLOYEE_ID)) AS Y2001,
       count(decode(TO_CHAR(HIRE_dATE,'YYYY'),2002,EMPLOYEE_ID)) AS Y2002,
       count(decode(TO_CHAR(HIRE_dATE,'YYYY'),2003,EMPLOYEE_ID)) AS Y2003,
       count(decode(TO_CHAR(HIRE_dATE,'YYYY'),2004,EMPLOYEE_ID)) AS Y2004,
       count(decode(TO_CHAR(HIRE_dATE,'YYYY'),2005,EMPLOYEE_ID)) AS Y2005
       FROM EMPLOYEES;
       
SELECT EMPLOYEE_ID,FIRST_NAME, CASE JOB_ID
                      WHEN 'IT_PROG' THEN 'PROGRAMMER'
                      WHEN 'FI_MGR' THEN 'MANAGER'
                      WHEN 'PU_CLERK' THEN 'CLERK'
                      ELSE 'OTHERS' END
                       JOB 
      FROM EMPLOYEES;
      
-- no of emps joined each year using group by clause

select extract(year from hire_date)as YEAR,count(1) as NO_OF_EMPLOYEES from 
employees group by extract(year from hire_date);

--TOTAL SALARIES OF DEPT 60,90

SELECT DEPARTMENT_ID,SUM(SALARY) FROM EMPLOYEES  WHERE DEPARTMENT_ID IN(90,60)GROUP BY DEPARTMENT_ID ;

--MAX SAL OF EACH DEPTS WHOSE MAX SAL>1000 USING HAVING CLAUSE

SELECT DEPARTMENT_ID,MAX(SALARY) FROM EMPLOYEES GROUP BY DEPARTMENT_ID HAVING MAX(SALARY)>10000;

-- USING WHERE,GROUP BY , HAVING TOGETHER

SELECT DEPARTMENT_ID,SUM(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID IN(90,60,80,70) GROUP BY DEPARTMENT_ID HAVING SUM(SALARY)>10000;