delimiter //
create procedure getn(in dno int,out dno1 int)
begin
select count(*) into dno1  from emp where deptno=dno; 
end//

delimiter ;

call getn(20,@c);

 select @c;
 
 
delimiter //
create procedure getnn1(in dno int,inout dno1 int)
begin
-- declare dno1 int;
select avg(sal) into dno1  from emp where deptno=dno; 
select count(*) into dno1  from emp where sal > dno1 ; 
end//

set @cc = 800; -- to set the var first to passit

call getnn1(20 , @cc );

select @cc;

-- select count(*) from emp where sal > (select avg(sal) from emp where deptno= 20);