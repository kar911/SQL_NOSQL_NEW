create database if not exists acts0923;
use acts0923;

create table EMP;
select * from emp where ename regexp '^[jm].*[srn]$';

-- +-------+--------+----------+------+------------+---------+---------+--------+
-- | EMPNO | ENAME  | JOB      | MGR  | HIREDATE   | SAL     | COMM    | DEPTNO |
-- +-------+--------+----------+------+------------+---------+---------+--------+
-- |  7566 | JONES  | MANAGER  | 7839 | 1981-04-02 | 2975.00 |    NULL |     20 |
-- |  7654 | MARTIN | SALESMAN | 7698 | 1981-09-28 | 1250.00 | 1400.00 |     30 |
-- |  7900 | JAMES  | CLERK    | 7698 | 1981-12-03 |  950.00 |    NULL |     30 |
-- |  7934 | MILLER | CLERK    | 7782 | 1982-01-23 | 1300.00 |    NULL |     10 |
-- +-------+--------+----------+------+------------+---------+---------+--------+

select * from emp where job regexp '^.{5}$'; -- must have 5 char but we are using regex

-- +-------+--------+-------+------+------------+---------+------+--------+
-- | EMPNO | ENAME  | JOB   | MGR  | HIREDATE   | SAL     | COMM | DEPTNO |
-- +-------+--------+-------+------+------------+---------+------+--------+
-- |  7369 | SMITH  | CLERK | 7902 | 1980-12-17 |  800.00 | NULL |     20 |
-- |  7876 | ADAMS  | CLERK | 7788 | 1983-01-12 | 1100.00 | NULL |     20 |
-- |  7900 | JAMES  | CLERK | 7698 | 1981-12-03 |  950.00 | NULL |     30 |
-- |  7934 | MILLER | CLERK | 7782 | 1982-01-23 | 1300.00 | NULL |     10 |
-- +-------+--------+-------+------+------------+---------+------+--------+


select * from emp where ename regexp '^[am].?l'; 

-- +-------+--------+----------+------+------------+---------+--------+--------+
-- | EMPNO | ENAME  | JOB      | MGR  | HIREDATE   | SAL     | COMM   | DEPTNO |
-- +-------+--------+----------+------+------------+---------+--------+--------+
-- |  7499 | ALLEN  | SALESMAN | 7698 | 1981-02-20 | 1600.00 | 300.00 |     30 |
-- |  7934 | MILLER | CLERK    | 7782 | 1982-01-23 | 1300.00 |   NULL |     10 |
-- +-------+--------+----------+------+------------+---------+--------+--------+



select * from emp where job regexp "man";

select * from emp where job regexp '^m.*r$'; 


 select distinct ifnull(sal,0) nn, ifnull(comm,0) as n1 from emp;


-- +---------+---------+
-- | nn      | n1      |
-- +---------+---------+
-- |  800.00 |    0.00 |
-- | 1600.00 |  300.00 |
-- | 1250.00 |  500.00 |
-- | 2975.00 |    0.00 |
-- | 1250.00 | 1400.00 |
-- | 2850.00 |    0.00 |
-- | 2450.00 |    0.00 |
-- | 3000.00 |    0.00 |
-- | 5000.00 |    0.00 |
-- | 1500.00 |    0.00 |
-- | 1100.00 |    0.00 |
-- |  950.00 |    0.00 |
-- | 1300.00 |    0.00 |
-- +---------+---------+


select * from emp order by emp.ename limit 4;


select * from emp order by emp.ename limit 3,3; -- skipp first 3

select * from emp order by emp.sal  desc limit 3;
select 'hello there' ff;

select job,sum(sal) totalbudget ,count(*)  count , round(avg(sal),0) perhead from emp group by job order by 2 desc;

select sum(sal) totalpool , count(*) count, deptno from emp where job = 'clerk' group by deptno;

select sum(sal) totalpool , deptno from emp where deptno =10 and job = 'analyst';

select sum(sal) totalpool , deptno ,count(*) n from emp where job = 'clerk' group by deptno having  n  >= 2;

select ifnull(mgr,0) mgr ,sum(sal) tot ,avg(sal) avgsal, count(*) counts  from emp group by mgr having avgsal > 2500;

use acts0923;


-- select * from emp where day(hiredate) = 3  and month(hiredate) =3 ;-- 

