--Psuedo Columns--

/*
1. ROWID--  returns physical address of a row in database table, no two rows within same table will have same row_id, used to delete duplicate records
2. ROWNUM -- temporary sequence number for each row in the order they fetched. rownum for a row changes from query to query
3. USER
4. LEVEL
5. CURRVAL and NEXTVAL
6. SYSDATE
7. SYSTIMESTAMP
8. ORA_ROWSCAN
*/

select uid,user from dual;

select rowid,uid,user from dual;

select  rowid,employee_id,first_name from employees where employee_id>10 ;

select systimestamp from dual;

select sysdate from dual;