--JOINS--

--Types of Joins--
--1. Inner join or Equi join
--2. Non-equvi join
--3. Self join
--4. Outer join
--5. cross join

/*1. Inner join or Equi join :
     Done based on common columns in different tables. To perform inner join there should be atleast one common column in both tables
     Column name need not to be same. Parent-child relationship is not needed. This is most used join. Any number of tables can be used
     in this kind of join
     Notes:
     While writin joing, precede column names with either table name or alias name of tables for faster access
*/

      select e.first_name, e.salary, e.job_i d, d.department_id, d.department_name, D.MANAGER_ID  from employees e, departments d
      where e.department_id=d.department_id and rownum<10;
      
      select e.first_name,j.job_title, d.department_name, l.city,l.street_address,l.state_province,c.country_name, r.region_name 
      from employees e, departments d, jobs j, locations l,countries c, regions r where E.DEPARTMENT_ID=D.DEPARTMENT_ID and
      D.LOCATION_ID=L.LOCATION_ID and L.COUNTRY_ID=C.COUNTRY_ID and C.REGION_ID = R.REGION_ID and rownum<10 and e.first_name <> 'Alexander';
      
      --Ansi style equi join
      
      select e.first_name,e.department_id from employees e join departments d on (e.department_id=d.department_id) where rownum<10; 
      
      --using can be used instead of on if join column name is same in joining tables
      --note: if we use using caluse, we can't use table alias to select join column
      select e.employee_id, first_name,e.job_id,d.department_name,department_id from employees e join departments d using (department_id); --less efficient


--2. Non-Equi join
      -- The above is called equi join because join is based on equality operator. If join is based on some other operator then
      -- that join is called non-equi join
      
      select e.employee_id, e.first_name,e.job_id,e.salary from employees e, sal_grade s where e.salary between s.lowsal and s.highsal;
      
      select e.employee_id, e.first_name, e.job_id,e.salary from employees e join sal_grade s on(e.salary between s.lowsal and s.highsal);
/*
3. Self Join
   --> A table joining itself. It is used when tables having self referential integrity
   --> To do self join, same table name must be listed twice with different alias
   --> self join is equi join with in the table
*/
 
 select e.employee_id,e.first_name, e.salary, m.manager_id from employees e, employees m
 where e.manager_id=m.employee_id order by e.manager_id desc;
 
 select e.employee_id,e.first_name, e.salary, m.manager_id from employees e join employees m
 on( e.manager_id=m.employee_id) order by e.manager_id desc;
 
 select e.first_name, e.salary, m.manager_id from employees e join employees m
 using(employee_id) order by e.manager_id desc;
 
 /*
 Outer Join:retrives even unmatched data i.e., null values
            Outer joins can only done between two tables
 1. Left Outer Join: retrives all data from left table even though there are no matching records in right table 
 */
 
 select e.employee_id, e.first_name,d.department_id,D.DEPARTMENT_NAME,D.LOCATION_ID from employees e, departments d
 where e.department_id=d.department_id(+);
 
 select e.employee_id,e.first_name,department_id,D.DEPARTMENT_NAME,D.LOCATION_ID from employees e left join departments d
 using(department_id);
 
 /*
Right outer join: returns all rows from right table even though there are no matches in the left table
 */
 
 select e.employee_id,e.first_name,d.department_id,d.department_name from employees e,
 departments d where e.department_id(+)=d.department_id;
 
select e.employee_id,e.first_name,department_id,d.DEPARTMENT_NAME,D.LOCATION_ID from employees e right join departments d
using (department_id);

/*
Full Outer Join: returns all rows both matched and unmatched.
It is nothing but union of left outer join and right outer join
*/

select e.employee_id,e.first_name,d.department_id,d.department_name from employees e, departments d;

 select e.employee_id, e.first_name,d.department_id,D.DEPARTMENT_NAME,D.LOCATION_ID from employees e, departments d
 where e.department_id=d.department_id(+)
 union
 select e.employee_id, e.first_name,d.department_id,D.DEPARTMENT_NAME,D.LOCATION_ID from employees e, departments d
 where e.department_id(+)=d.department_id;
 
 /*Cross join: cross products of two tables*/
  select e.first_name,d.department_name from employees e , departments d;
 
 select e.first_name,d.department_name from employees e cross join departments d;
 
 
 /*Natural Join:
   --> can only be done using ANSI standard
   --> similar to equi join
   --> done when common column name is same
   --> no need of specifying condition explicitly, oracle automatically performs join check on common column
 */
 
 select e.employee_id, e.first_name,department_id,d.department_name from employees e natural join departments d;