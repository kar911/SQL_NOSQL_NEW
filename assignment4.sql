-- Creating tables
CREATE TABLE Vehicle (
    Vid INTEGER,
    Vname VARCHAR(50),
    Price DECIMAL,
    Description VARCHAR(255)
);

CREATE TABLE Customer1 (
    Custid INTEGER,
    Cname VARCHAR(50),
    Address VARCHAR(255)
);

CREATE TABLE Salesman (
    Sid INTEGER,
    Sname VARCHAR(50),
    Address VARCHAR(255)
);

CREATE TABLE Cust_Vehicle (
    Custid INTEGER,
    Vid INTEGER,
    Sid INTEGER,
    Buy_price DECIMAL
);

-- Inserting data into Vehicle table
INSERT INTO Vehicle (Vid, Vname, Price, Description) VALUES (1, 'Activa', 80000, 'ksldjfjksj');
INSERT INTO Vehicle (Vid, Vname, Price, Description) VALUES (2, 'Santro', 800000, 'kdjfkjsd');
INSERT INTO Vehicle (Vid, Vname, Price, Description) VALUES (3, 'Motor bike', 100000, 'fdkdfj');

-- Inserting data into Customer table
INSERT INTO Customer1 (Custid, Cname, Address) VALUES (1, 'Nilima', 'Pimpari');
INSERT INTO Customer1 (Custid, Cname, Address) VALUES (2, 'Ganesh', 'Pune');
INSERT INTO Customer1 (Custid, Cname, Address) VALUES (3, 'Pankaj', 'Mumbai');

-- Inserting data into Salesman table
INSERT INTO Salesman (Sid, Sname, Address) VALUES (10, 'Rajesh', 'Mumbai');
INSERT INTO Salesman (Sid, Sname, Address) VALUES (11, 'Seema', 'Pune');
INSERT INTO Salesman (Sid, Sname, Address) VALUES (13, 'Rakhi', 'Pune');

-- Inserting data into Cust_Vehicle table
INSERT INTO Cust_Vehicle (Custid, Vid, Sid, Buy_price) VALUES (1, 1, 10, 75000);
INSERT INTO Cust_Vehicle (Custid, Vid, Sid, Buy_price) VALUES (1, 2, 10, 790000);
INSERT INTO Cust_Vehicle (Custid, Vid, Sid, Buy_price) VALUES (2, 3, 11, 80000);
INSERT INTO Cust_Vehicle (Custid, Vid, Sid, Buy_price) VALUES (3, 3, 11, 75000);
INSERT INTO Cust_Vehicle (Custid, Vid, Sid, Buy_price) VALUES (3, 2, 10, 800000);


-- 2
create index vehi_pric_idx on Vehicle(price);

-- 3
-- select c.cname ,v.vname ,s.sname, (v.price- cv.buy_price) discount 
-- from customer1 c inner join cust_vehicle cv inner join vehicle v inner join salesman s ;

SELECT c.Cname AS Customer_Name,v.vname ,s.sname, (v.Price - cv.Buy_price) AS Total_Discount
FROM customer1 c 
JOIN cust_vehicle cv ON c.Custid = cv.Custid
JOIN vehicle v ON cv.vid = v.vid
JOIN salesman s ON cv.sid = s.sid;

-- Vehicle : Vid , Vname , Price , desc
-- customer : Custid , Cname , address
-- salesman : Sid , Sname , adress
-- cust-vehicle : Custid , Vid , Sid , Buy_price;

-- 4
SELECT c.Cname AS Customer_Name,v.vname ,s.sname, (v.Price - cv.Buy_price) AS Total_Discount
FROM customer1 c 
JOIN cust_vehicle cv ON c.custid = cv.custid
JOIN vehicle v ON cv.vid = v.vid
JOIN salesman s ON cv.sid = s.sid where s.address = 'Pune';

-- 5
SELECT count(c.Cname) AS Customer_Count
FROM customer1 c 
JOIN cust_vehicle cv ON c.Custid = cv.Custid
JOIN vehicle v ON cv.vid = v.vid where v.vname = 'Motor bike';

-- 6
create view find_discount
as
select cname,vname,price,buy_price,price-buy_price 'discount'
from customer1 c inner join cust_vehicle cv on c.custid=cv.custid inner join vehicle v on
v.vid=cv.vid;

select * from find_discount;

-- 7
SELECT c.Cname AS Customer_Name,v.vname ,s.sname, (v.Price - cv.Buy_price) AS Total_Discount
FROM customer1 c 
JOIN cust_vehicle cv ON c.Custid = cv.Custid
JOIN vehicle v ON cv.vid = v.vid
JOIN salesman s ON cv.sid = s.sid ;

-- 8
create view my_hr 
as select empno,ename,job,ifnull(comm,0) as comm from emp where comm >0 ;

select * from my_hr;

-- 9
create view mgr30 
as select * from emp where deptno =10;
select * from mgr30;

-- drop view mgr30;
-- 10
insert into mgr30
values(1001,'KAR9','CTO',null,'2022-01-09',99999,null,0);

-- 11
desc dept;

insert into dept value(0,'CO','Indore');
insert into dept value(4,'Cell','Hell');
insert into dept value(5,'Tell','Pune');

select * from dept;
-- 12
commit;
insert into dept value(3,'Comm','Keral');
select * from dept;
rollback; -- nothing happning

-- 13
desc emp; 
insert into emp value(101,'name1','JOB1',7666,'2023-04-04',9000,300,10);
insert into emp value(102,'name2','JOB1',7666,'2023-01-04',9000,30,10);
insert into emp value(103,'name3','JOB1',7666,'2023-05-04',9000,100,10);

savepoint a;

insert into emp value(104,'name4','JOB2',7661,'2023-04-04',9001,300,10);
insert into emp value(105,'name5','JOB2',7661,'2023-01-04',9001,30,10);
insert into emp value(106,'name6','JOB2',7661,'2023-05-04',9001,100,10);

savepoint b;
delete from emp where empno =101;
delete from emp where empno =104;

select * from emp;
set @@autocommit = 0;
select @@AUTOCOMMIT ;

rollback to b;

select * from emp;

rollback to a;

commit;

select * from emp;

-- 14

delimiter //
create procedure getMin(in deptn int, out minsal decimal(7,2))
begin
select min(sal) into minsal from emp where deptno = deptn;
end//
delimiter ;

set @dpno = 0;

call getMin(10,@dpno);

select @dpno;
select min(sal) from emp where deptno = 10; -- correct