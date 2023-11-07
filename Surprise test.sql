-- PRN NO 230940125053   utkarsh talreja
-- PRN NO 230940125024   kartik moyade




create table Salespeople (
    snum int,
    sname varchar(50),
    city varchar(50),
    comm decimal(4,2)
);

insert into Salespeople values
(1001, 'Peel', 'London', .12),
(1002, 'Serres', 'San Jose', .13),
(1004, 'Motika', 'London', .11),
(1007, 'Rifkin', 'Barcelona', .15),
(1003, 'AxelRod', 'New York', .10),
(1005, 'Fran', 'London', .26);

create table Customers (
    cnum int,
    cname varchar(50),
    city varchar(50),
    rating int,
    snum int
);

insert into Customers values
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanni', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 200, 1002),
(2004, 'Grass', 'Berlin', 300, 1002),
(2006, 'Clemens', 'London', 100, 1001),
(2008, 'Cisneros', 'San Jose', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004);

create table Orders (
    onum int,
    amt decimal(8,2),
    odate date,
    cnum int,
    snum int
);

insert into Orders values
(3001, 18.69,'1996-10-03' ,2008 ,1007),
(3003 ,767.19 ,'1996-10-03' ,2001 ,1001),
(3002 ,1900.10 ,'1996-10-03' ,2007 ,1004),
(3005 ,5160.45 ,'1996-10-03' ,2003 ,1002),
(3006 ,1098.16 ,'1996-10-03' ,2008 ,1007),
(3009 ,1713.23 ,'1996-10-04' ,2002 ,1003),
(3007 ,75.75 ,'1996-10-04' ,2002 ,1003),
(3008 ,4723.00 ,'1996-10-05' ,2006 ,1001),
(3010 ,1309.95 ,'1996-10-06' ,2004 ,1002),
(3010 ,9891.88 ,'1996-10-06' ,2006 ,1001);


-- 1
select * from salespeople;
-- 2
select * from customers where rating = 100 ;
--  3
select cnum ,
    cname ,
    ifnull(city,'not mentioned') city ,
    rating ,
    snum from customers;
    
-- 4
select * from salespeople s where (select count(*) from orders o where o.snum = s.snum) >=2;

-- 5
select sname, cname from salespeople s, customers c where s.snum = c.snum  ;

-- 6
select sname,snum from salespeople s where (
select count(*) from customers c where c.snum = s.snum) > 2;

-- 7
select c.cname from customers c join salespeople s  
where  c.city = s.city and c.snum = s.snum ;

select c.cname from customers c , salespeople s  
where  c.city = s.city and c.snum = s.snum ;
-- 8
select s.snum , max(o.amt) max_order_amt from salespeople s join orders o 
on o.snum = s.snum group by o.snum; 

select distinct(s.sname) as sname ,
(select max(amt) from orders o where s.snum=o.snum ) max_amt from salespeople s;

--  9
select * from customers c 
where exists(select o.cnum from 
			orders o where monthname(o.odate) = 'october' and day(o.odate)= 3 and c.cnum = o.cnum);
            
-- 10
-- select c.* ,( select * from customers c1  where c.rating = c1.rating  and  c1.cname != c.cname) from customers c;

select c.* ,c1.* from customers c join customers c1 on c.cname != c1.cname  and c.rating = c1.rating 
where  c.cnum > c1.cnum;

-- 11
select * from customers c
 where c.city = (select c1.city from customers c1 where 
 c.city = c1.city and c1.snum = (select snum from salespeople where sname = 'serres' ));

-- 12
select * from orders where amt < (select min(amt) from orders where snum in (select snum from customers where city = 'san jose' ));
-- 13

select (s.comm * o.amt) comm , s.sname , o.cnum from salespeople s join orders o on s.snum = o.snum  where cnum in (select cnum from customers where rating > 100);

-- 14 

-- 15
select s.sname from  salespeople s where not exists(select c.snum from customers c where c.city = s.city);
-- 16
select * from customers where cname like 'C%' or cname like 'G%' or cname like 'L%';
  
select * from customers where cname regexp '^[CGLcgl]';

-- 17
select format(' for city() the highest rating is ()') from customers c ;
-- 18


select s.snum , max(o.amt) max_order_amt from salespeople s join orders o 
on o.snum = s.snum group by o.snum; 


-- 2
delimiter //
create procedure disp()
begin
select cname from customers c where rating > 200 and
	snum = (select snum from salespeople where sname = 'serres') ; 
end//
delimiter ;

call disp();

-- 3
delimiter //
create procedure disp()
begin
declare comm2 varchar(20); 
declare vstop int default 0; 
declare comm1 double;
declare empcur cursor for select comm , sname  from Salespeople; -- it initailize a pointer on the out put of this query
declare continue handler for not found set vstop = 1; -- this is used to check if iteration next is not present then set vstop = 1
open empcur; -- opening cursor for getting data
lable1:loop -- for every itter the empcur will fet update to next values
	fetch empcur into comm1, comm2; -- getting  comm1 as comm and comm2  as city for each iteration of cursor empcur of the row till vstop is 0
	if vstop =1 then
		Leave lable1;
	end if;
	select case when comm1 between 0.09 and 0.13 then 'junior'
				when comm1 between 0.13 and 0.17 then 'assistant'
				else 'senior' end designation , comm2 ;
end loop;
close empcur;
end//
delimiter ;

set @cc = '800'; -- to set the var first to passit

call disp();

select @cc;

drop procedure disp;

-- 4
CREATE TABLE customer_monitor (
    custid INT,
    oldcustname VARCHAR(255),
    newcustname VARCHAR(255),
    oldrating INT,
    newrating INT,
    user VARCHAR(55),
    date DATE,
    action VARCHAR(25)
);


delimiter //
create trigger trigge_up_cust 
before update on customers
for each row
begin
	-- insert into logss value(default,now(),user(),'update');
    INSERT INTO customer_monitor 
    VALUE(old.cnum, old.cname, new.cname, old.rating, new.rating, user(),curdate(),'update');

end//
delimiter ;

delimiter //
create trigger trigge_in_cust 
before insert on customers
for each row
begin
	INSERT INTO customer_monitor 
    VALUE(null, null, new.cname, null, new.rating, user(),curdate(),'insert');
end//
delimiter ;

-- insert into logss value(default, now(),user(),'insert');

drop trigger trigge_in_cust;
drop trigger trigge_up_cust;

-- select @@autocommit;
-- set @@autocommit = 0;
SET SQL_SAFE_UPDATES = 0;
use acts0923;
select * from customer_monitor;

insert into customers value(20172, 'Perei2raaa', 'Romee', 100, 1012);
delete from customers where cname = 'Pereiraaa';

update customers set cname = 'Pereiraaa2' where cname ='Perei2raaa';

-- 5
set global log_bin_trust_function_creators = 1;

delimiter  //
create function gencode(cname varchar(50),city varchar(50),cid int) returns varchar(100)
begin
 return concat(substr(cname,1,3),substr(city,1,3),LEFT(cid, 3));
end //
delimiter  ;

select gencode('karnot','tikool',91111);