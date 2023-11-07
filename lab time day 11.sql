use acts0923;
select * from emp;


delimiter //
create procedure somename(in x int)
begin
if x > 2 then
select 1;
elseif x = 2 then
select 2;
else
select 0;
end if;
end//
delimiter ;

drop procedure somename;

call somename(3);

delimiter //
create procedure updatesal (in eno int, out nsal double(10,2), out status varchar(20))
begin
declare vsal double(20,2);
select sal into vsal
from emp
where empno=eno;
if vsal <1500 then
set nsal=vsal*1.20;
update emp
set sal = nsal
where empno=eno;
elseif vasal<2500 then
set nsal=vsal*1.15;
else
set nsal=vsal*1.10;
update emp
set sal=nsal
where empno=eno;
else 
select 1;
end //
delimiter ;








delimiter //
create procedure somename(num int)
begin
declare n int default 1;
declare str varchar(20) default '';
while n <= num do
str=concat(str,',',n);
set n=n+1;
end while;
set str=substr(2);
end//
delimiter ;



show tables;


delimiter //
create procedure repeatdemo(num int)
begin
declare n int default 1;
declare str varchar(20) default '';
repeat
	set str=concat(str,',',n);
	set n=n+1;
	until n>num;
end repeat;
set str = substr(str,2);
select str;
end //
delimiter ;




delimiter //
create procedure loopdemo(num int)
begin
declare n int default 1;
declare str varchar(20) default '';
lb1:loop
		set str=concat(str,',',n);
		set n=n+1;
    if n > num then
		leave lb1; -- we have to use the lable name even if we are  using single
	else
		iterate lb1; -- we have to use the lable name even if we are  using single
	end if;
end loop;
set str = substr(str,2);
select str;
end //
delimiter ;




delimiter //
create procedure loopdemo(num int)
begin
declare n int default 1;
declare str varchar(20) default '';
lb1:loop
		set n=n+1;
    if n > 4 then
		leave lb1; -- we have to use the lable name even if we are  using single
	else
		set str = lpad('',n,'*');
		set  str = concat(str,'\n'); -- we have to use the lable name even if we are  using single
	end if;
end loop;
set str = substr(str,2);
select str;
end //
delimiter ;


 
delimiter //
create procedure loopdemo31(num int)
begin
declare n int default 1;
declare str varchar(20) default '';
lb1:loop
set n=n+1;
if n > num then 
	leave lb1;
else
	set str = concat(LPAD('', num-n,' '),RPAD(, num-n+1, ' '));
end if;
select str;
end loop;
end //

delimiter ;

use acts0923;

select pad('*',3,' ');

 select concat(LPAD('', 6, '< >'),RPAD('*', 7, '< >'));

call loopdemodimond(10);
drop procedure loopdemo;



delimiter //
create procedure loopdemodimond(num int)
begin
declare n int default 1;
declare str varchar(50) default '';
declare scnt int default 0;
set scnt = floor(num/2);
while n<= num do
set str = concat(str,'\n',lpad('',scnt,' '),lpad('',n,'*'));
set n = n+2;
set scnt = scnt - 1;
select n,scnt,str;
end while;
set scnt =1;
set n =num -2;
while n>=1 do
set str = concat(str,'\n',lpad('',scnt,' '),lpad('',n,'*'));
set n = n-2;
set scnt = scnt + 1;
select n,scnt,str;
end while;
select str;
end //
delimiter ;


delimiter //

declare veno, vdeptno, vstop int default 0;


