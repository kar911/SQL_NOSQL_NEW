-- 1
select distinct(mgr) from emp ;
select distinct e1.* from emp e1 join emp e2 on e1.EMPNO = e2.mgr where e1.SAL > 1500;

-- 2 
select * from emp  where ( sal  > 1250  and sal < 2000 );
-- 3
select * from emp  where sal in (1600,800,1900);
-- 4
select * from emp where ename regexp 'r.$';
-- 5
select * from emp where ename regexp '^a.*n$';
select * from emp where ename like 'a%n';

-- Q2
-- 1
select * from emp where sal > 1250 and deptno = 30;
-- 2
select * from emp where (sal >= 1250 and sal <= 3000);
-- 3
select * from emp where (sal > 1250 and sal < 3000);
-- 4
select * from emp where sal in (3000,1250,2500);
-- 5
select * from emp where ENAME  = 'smith';
-- 6
select * from emp where ENAME  like 's%';
-- 7
select * from emp where ENAME  like '%s';
-- 8
select * from emp where ENAME regexp '^.i';
-- 9
select * from emp where ENAME regexp '^a.*l.*n$';
select * from emp where ENAME like 'a%l%n';
-- 10
select * from emp where ENAME regexp '^a.b.*p.$';
select * from emp where ENAME like 'a_b%p_';
-- 11
select * from emp where ENAME regexp '^[asw]';

-- 3Q
-- 12
select job, max(sal) max_sal , min(sal) min_sal from emp group  by job;
-- 13
select count(*) from emp where isnull(comm) or comm =0 ;
-- 14
select sum(sal) from emp where DEPTNO =10;
-- 15
select DEPTNO,job, max(sal) max_sal , avg(sal) min_sal from emp group  by deptno,job;
-- 16
select DEPTNO, max(sal) from emp where DEPTNO > 15  group  by  DEPTNO order by 1;
-- 17
select deptno, sum(sal) total_buget from emp group by deptno having sum(sal) >3000;
-- 18
select deptno from emp group by DEPTNO having count(*) > 4;
-- 19
select job,count(*) count from emp where sal > 2000 group by job;
-- 20
select lower(ename) ename ,lower(job) job from emp; 
-- 21
select lpad(ename,15," ") ename, lpad(job,15,' ') job  from emp;
-- 22
select mgr ,min(sal) min_sal, max(sal) max_sal ,avg(sal) avg_sal from emp group by mgr;
-- 23 wip
select mgr ,sum(sal+ifnull(comm,0)) earnings , avg(sal+ifnull(comm,0)) avg_earning from emp where sal > 2000 and deptno in (10,20) group by mgr;
-- 24
select * from emp where (HIREDATE BETWEEN '1980-08-01' AND '1980-08-31')
AND (sal > 1500 AND sal < 2500);
-- 25
select * from emp where monthname(hiredate) in ('august','may','december');
-- 26
select date_format(hiredate,'%d/%m/%y') hiredate from emp;
-- 27
select concat(substr(empno,2,5),right(job,2))empcode, empno ,ename ,job from emp;
-- 28
select concat('$', format(ifnull(comm,0),0)) commission from emp where ENAME regexp '^a.*n$';
select concat('$', format(ifnull(123455667,0),0) );

-- 29
select empno , ename ,sal,comm,
 case when  comm >= 600 then 'excellent keep it up'
	when comm < 600 or not isnull(comm) then 'good'
    else 'need improvement'
    end remark from emp ;

-- 30
select empno , ename ,deptno,
 case when  deptno = 10 then 'HR'
	when deptno = 20  then 'Admin'
    when deptno = 30  then 'Accounts'
    else 'Purchase'
    end department from emp ;
    
-- 31
create table mydept_DBDA
(
deptid int primary key,
dname varchar(20) not null unique,
dloc varchar(20)
);


insert into mydept_DBDA values(30,'Purchase','Mumbai');

create table myemployee
(
empno int primary key,
fname varchar(15) not null,
mname varchar(15),
lname varchar(15) not null,
sal float(9,2) check(sal >=1000),
doj date,
passportnum varchar(15) unique,
deptno int,
constraint fk_deptno foreign key(deptno) references mydept_DBDA(deptid) on
delete set null
on update cascade
);


create table marks(
studid int,
courseid int,
marks int,
constraint pk primary key(studid,courseid),
constraint fk_sid foreign key (studid) references student(sid) on delete cascade,
constraint fk_cid foreign key (courseid) references course(cid)
);

select * from marks;

set sql_safe_updates = 0;

savepoint xx;

-- 37
update emp
set sal = sal*1.15
where comm  is not null and comm >  0;

select * from emp;

-- 35
update emp
set sal = sal*1.15 +ifnull(comm,0) , job = 'manager' ,mgr = 7777
where deptno = 10;

-- 36
update emp
set job = 'sc clerk'
where ename = 'smith';

-- 38
select * from emp  where sal > (select sal from emp  where ename= 'smith');

-- 39
select * from emp  where deptno = (select deptno from emp  where ename= 'smith');

-- 40
select * from emp  
where sal 
between (select sal from emp  where ename= 'miller') 
and (select sal from emp  where ename= 'jones');

-- 44
select * from emp where sal > (select sal from emp where ename='smith') or sal > (select sal from emp where ename='alan');

-- 45
select * from emp where sal > (select avg(sal) from emp where deptno=10);

-- 46
select ename, sal from emp where sal > (select avg (sal)from emp where (select deptno from emp where ename='allen'));

-- 47
select * from emp  where deptno = 40;

-- 48
select * from emp e1 where sal > (select avg(sal) from emp e2 where deptno=e1.deptno);

-- 49
select distinct e1.* from emp e1 join emp e2 on e1.EMPNO = e2.mgr where e1.SAL < e2.sal;

-- 50
select e1.ename, e1.deptno, e1.sal
from emp e1
WHERE e1.sal > (
    select avg(e2.sal)
    from emp e2
    WHERE e1.deptno = e2.deptno
);

-- 51
select ename , deptno from emp order by 2;

-- 52
