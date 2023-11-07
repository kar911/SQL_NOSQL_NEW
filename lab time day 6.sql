desc emp;

select (CURRENT_DATE);

select (NOW);

alter table dummy
add newname varchar(10) not null;

alter table dummy
add lnamee1 varchar(10) not null
;

use acts0923;

desc dummy;

alter table dummy
add fname varchar(10) not null
after lname;

alter table dummy
modify dummy1 int;

alter table dummy
modify dummy1 date
not null
default (CURRENT_DATE);

alter table dummy
add dummy1 int
not null;

select * from dummy;

SET SQL_SAFE_UPDATES = 0;

delete from dummy;


show create table emp;

-- +-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-- | Table | Create Table                                                                                                                                                                                                                                                                                                                                                               |
-- +-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-- | emp   | CREATE TABLE `emp` (
--   `EMPNO` int NOT NULL,
--   `ENAME` varchar(10) DEFAULT NULL,
--   `JOB` varchar(9) DEFAULT NULL,
--   `MGR` int DEFAULT NULL,
--   `HIREDATE` date DEFAULT NULL,
--   `SAL` decimal(7,2) DEFAULT NULL,
--   `COMM` decimal(7,2) DEFAULT NULL,
--   `DEPTNO` int DEFAULT NULL,
--   PRIMARY KEY (`EMPNO`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
-- +-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

use dbda;

select * from information_schema.key_column_usage 
where table_name = 'emp';

-- +--------------------+-------------------+-----------------+---------------+--------------+------------+-------------+------------------+-------------------------------+-------------------------+-----------------------+------------------------+
-- | CONSTRAINT_CATALOG | CONSTRAINT_SCHEMA | CONSTRAINT_NAME | TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | COLUMN_NAME | ORDINAL_POSITION | POSITION_IN_UNIQUE_CONSTRAINT | REFERENCED_TABLE_SCHEMA | REFERENCED_TABLE_NAME | REFERENCED_COLUMN_NAME |
-- +--------------------+-------------------+-----------------+---------------+--------------+------------+-------------+------------------+-------------------------------+-------------------------+-----------------------+------------------------+
-- | def                | acts0923          | PRIMARY         | def           | acts0923     | emp        | EMPNO       |                1 |                          NULL | NULL                    | NULL                  | NULL                   |
-- +--------------------+-------------------+-----------------+---------------+--------------+------------+-------------+------------------+-------------------------------+-------------------------+-----------------------+------------------------+


-- if two data bases have same name tables
select * from information_schema.key_column_usage 
where table_name = 'dummy' and table_schema ='acts0923' ;

-- +--------------------+-------------------+-----------------+---------------+--------------+------------+-------------+------------------+-------------------------------+-------------------------+-----------------------+------------------------+
-- | CONSTRAINT_CATALOG | CONSTRAINT_SCHEMA | CONSTRAINT_NAME | TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | COLUMN_NAME | ORDINAL_POSITION | POSITION_IN_UNIQUE_CONSTRAINT | REFERENCED_TABLE_SCHEMA | REFERENCED_TABLE_NAME | REFERENCED_COLUMN_NAME |
-- +--------------------+-------------------+-----------------+---------------+--------------+------------+-------------+------------------+-------------------------------+-------------------------+-----------------------+------------------------+
-- | def                | acts0923          | PRIMARY         | def           | acts0923     | emp        | EMPNO       |                1 |                          NULL | NULL                    | NULL                  | NULL                   |
-- +--------------------+-------------------+-----------------+---------------+--------------+------------+-------------+------------------+-------------------------------+-------------------------+-----------------------+------------------------+





create table branch(
bid int,
brname char(30) NOT NULL, 
brcity char(10) NOT NULL, 
primary key(bid)

);


create table branch(
bid int,
brname char(30) NOT NULL, 
brcity char(10) NOT NULL, 
primary key(bid)

);


create table customer(
cno int ,
cname char(20) NOT NULL, 
caddr char(35) NOT NULL,
city char(20), 
primary key(cno)

);


create table loan_application(
lno int,
lamtrequired double, 
lamtapproved double,
l_date date, 
primary key(lno)
);

create table br_cust_loan(
bid int,
cno int,
lno int, 
primary key(bid,cno,lno),
constraint const_bid foreign key(bid) references branch(bid) 
on delete cascade
on update cascade,
constraint const_cno foreign key(cno) references customer(cno) 
on delete cascade
on update cascade,
constraint const_lno foreign key(lno) references loan_application(lno) 
on delete cascade
on update cascade
);


insert into branch values(12,'linux',98);
insert into branch values(12,'linux',98);
insert into branch values(12,'linux',98);
insert into branch values(12,'linux',98);


insert into customer values(13,'linux',88);
insert into customer values(13,'linux',88);
insert into customer values(13,'linux',88);
insert into customer values(13,'linux',88);
insert into customer values(13,'linux',88);


insert into loan_application values(12,'c++',98);


ALTER TABLE employees
MODIFY name VARCHAR(50) NOT NULL;

use acts0923;

drop table loan_application;
drop table br_cust_loan;


ALTER TABLE loan_application
MODIFY lamtrequired DOUBLE,
ADD CONSTRAINT loan_application_chk_1 CHECK (lamtapproved >= lamtrequired);

select * from information_schema.key_column_usage 
where table_name = 'br_cust_loan' and table_schema ='acts0923' ;


select @@autocommit,@@sql_safe_updates;


select * from emp e
where not exists( select * from emp e2 where e2.mgr = e.EMPNO );

-- join equi
select * from emp e join dept d where e.DEPTNO=d.DEPTNO;
select * from emp e inner join dept d where e.DEPTNO=d.DEPTNO;
select * from emp e , dept d where e.DEPTNO=d.DEPTNO;

-- join non equi
select * from emp e join salgrade d where e.SAL between d.LOSAL and d.HISAL;
select * from emp e inner join salgrade d where e.SAL between d.LOSAL and d.HISAL;
select * from emp e , salgrade d where e.SAL between d.LOSAL and d.HISAL;

-- self join
select * from emp e join emp e1 where e.mgr =e1.empno;
select * from emp e inner join emp e1 where e.DEPTNO=d.DEPTNO;
select * from emp e , emp e1 where e.DEPTNO=d.DEPTNO;




