 -- SET OPERATORS --
 /*
 1. UNION
 2. UNION ALL
 3. INTERSECT
 4. MINUS
 
 SYNTAX:
          SELECT STATEMENT1
             UNION/UNION ALL/ INTERSECT/ MINUS
          SELECT STATEMENT2
          
 RULES:
 1. No of columns returned by first select statement1 should be equal to number of columns returned by second select statement
 2. corresponding column datatypes must be same.
 */
 
 /*
 1. UNION:
 Note: If order by to be used with union, it should be used with last query
 */
 
 select job_id,salary from employees where department_id in(30,20)
 union 
 select job_id,salary from employees where department_id=20 order by job_id;
 
 /*
 2. UNION ALL: Similar to UNION but returns duplicates also
 */
 
  select job_id,salary from employees where department_id in(30,20)
 union all
 select job_id,salary from employees where department_id=20 order by job_id;
 
 
 /*
 3. INTERSECT: Returns common rows from two select statements
 */
   select job_id,salary,department_id from employees where department_id in(30,20)
 intersect
 select job_id,salary,department_id  from employees where department_id=20 order by job_id;
 
 /*
 4. MINUS: returns rows of first select statement which are not present in the second select statment
 */
select job_id,salary,department_id from employees where department_id in(30,20)
 minus
select job_id,salary,department_id  from employees where department_id=20 order by job_id;