use acts0923;

select * from emp;

-- 1 to 14  

select * from emp where sal > 2000 and comm >200;

select * from emp where job = 'clerk' or sal > 2000;

select * from emp where sal in (1250,1100,2850);

select * from emp where sal < 2850 and sal > 1250;

select * from emp where ename like "%as";

select * from emp where job like "c%k";

select * from emp where job like "__l%m__";

select * from emp where sal not in (1250,1100,2850);

select * from emp where sal not between 1251 and 2849;

select * from emp where job like "c_e%k";

select * from emp where comm is null;

select * from emp where sal is null and ename like "s%";

select * from emp where job like "_____";

select * from emp where ename like 'a%' and job regexp "^.{5}$";

-- 1 to 14  
use acts0923;


-- Q2 

select ename, sal, deptno from emp where deptno in (20,30,40);

select 1.10*ifnull(sal,0) + ifnull(comm,0) from emp;

select ename namee , job jobname from emp where HIREDATE < 19860101 and sal between 1200 and 2500;
 select ename namee , job jobname from emp where year(HIREDATE) < 1986 and sal between 1200 and 2500;
 select ename namee , job jobname from emp where HIREDATE < '1986-01-01' and sal between 1200 and 2500;
 
 
select ename , empno , DEPTNO from emp where mgr = 7698;

select job , ename ,sal from emp where deptno in (10,30);

select concat(ename,", ",deptno) 'Emp info' from emp;

select * from emp where mgr is null;

-- 9
select * from emp where job like "age%" or job like "%age%" or job like "%age";
select * from emp where job regexp 'age';

-- 12
select ename from emp where ENAME regexp '.*_.*';


-- Group functions

select deptno ,round(max(sal),0) max, round(min(sal),0) min, round(sum(sal),0) tatal , round(avg(sal),0) avg 
from emp 
group by deptno;

select deptno ,count(*) as "total no of managers" from emp where job='manager' group by deptno;


select deptno ,sum(sal) totsal from emp where job !='manager' group by deptno having totsal > 2000;

-- single row function

select ename, concat(substr(ename,2,5),concat(job,2,4),'@mycompany.com')  email, ename from emp;

select * from emp where monthname(hiredate) = 'september';

select empno,ename,deptno ,year(now()) - year(hiredate) exp from emp where (year(now()) - year(hiredate)) >= 18;

select * from emp where day(hiredate) = 3 ;

select * from emp where year(hiredate) between 1981 and 1983;
