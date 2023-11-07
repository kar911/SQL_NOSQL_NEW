create table users (
id int primary key auto_increment,
name varchar(20),
email varchar(20) unique,
password varchar(20),
reg_amt double,
reg_date date,
role varchar(10));


create database java;


use java
-- desc bank_accounts;

select * from bank_accounts;

#users table data
insert into users values(1,'rama','rama@gmail.com','1234',1500,'2017-1-23','ADMIN');

insert into users values(2,'Kiran','kir@gmail.com','123',1200,'2018-5-29','CUSTOMER');

insert into users values(3,'Shekhar','shek@gmail.com','1235',1800,'2016-3-4','CUSTOMER');

insert into users values(4,'Riya','riya@gmail.com','4235',1700,'2017-3-4','CUSTOMER');

insert into users values(5,'Raj','raj@gmail.com','4535',1900,'2019-3-4','CUSTOMER');


create table bank_users(id int primary key,name varchar(20),
password varchar(20));
insert into bank_users values(1,'Madhura','1234');
insert into bank_users values(2,'Raj','3456');
insert into bank_users values(3,'Rama','2233');
insert into bank_users values(4,'Mohit','3457');
commit;

create table bank_accounts(ac_no int primary key,user_id int ,type varchar(10),balance double,CONSTRAINT fk_users  FOREIGN KEY (user_id) REFERENCES bank_users(id));

insert into bank_accounts values(101,1,'Saving',10000);
insert into bank_accounts values(102,1,'Current',5000);
insert into bank_accounts values(103,2,'FD',300000);


drop procedure transfer_funds;

DELIMITER $$
create   procedure transfer_funds(
 in sid int ,
 in did int,
 in amt double ,
 out sbal double,
 out dbal double 
) 
begin
update bank_accounts set balance=balance-amt where ac_no=sid;
update bank_accounts set balance=balance+amt where ac_no=did;
select balance into sbal from bank_accounts where ac_no=sid;
select balance into dbal from bank_accounts where ac_no=did;
end$$
 DELIMITER ;

How to invoke a stored procedure from mysql ?

call transfer_funds(101,102,500,@src,@dest);
select @src as src_bal;
select @dest as dest_bal;

select 12 
union
select 24
union 
select 36;


-- CREATE VIEW Brazil Customers AS



