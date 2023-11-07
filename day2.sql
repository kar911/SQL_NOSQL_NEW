create table student(
sid int  primary key,
sname varchar(30) not null,
mobile int unique
);

insert into student values(12,'Atharva',123456);
insert into student values(13,'Atharva',123457);
insert into student(sid,sname) values(14,'Rajan');


-- course(cname,duration,fname)
create table course(
cname varchar(30) primary key,
duration int,
fname varchar(30));

insert into course values('java',120,'Madhura');
insert into course values('c++',100,'Tushar');
insert into course values('Linux',60,'Dube');


create table student_marks(
sid int,
cr_name varchar(30),
marks int,
primary key(sid,cr_name),
constraint fk_sid foreign key(sid) references student(sid) 
on delete cascade
on update cascade,
constraint fk_cname foreign key(cr_name) references course(cname));




 

insert into student_marks values(12,'linux',98);
insert into student_marks values(13,'linux',88);
insert into student_marks values(12,'c++',98);
insert into student_marks values(12,'java',98);
insert into student_marks values(13,'java',88);

-- ------invalid ---> same combination
insert into student_marks values(13,'java',88);

-- ------invalid ---> sid is wrong not avaialable in student
insert into student_marks values(17,'java',88);

-- ------invalid ---> cname is wrong not avaialable in course
insert into student_marks values(17,'.net',88);



-- ----valid  ---> on update cascade will update id 13 in 
-- -----student_marks table to 16
update student
set sid=16
where sid=13;

-- ----valid  ---> on delete cascade will delete all rows from 
--  -----student_marks with id 13  
delete from student where sid=13;

-- ---invalid ---> on update cascade is not given on cname as foreign key
update course set cname='c++ 18'
where cname='c++';

-- ---invalid ---> on delete cascade is not given on cname 
-- ----as foreign key, and student_marks table contains name 'java'
delete from course where cname='java';


-- invalid ---> on delete cascade is not given on cname 
-- ----as foreign key, and student_marks table contains name 'c++'
delete from course where cname='c++';


-- ---delete all rows from student_marks
delete from student_marks where cr_name='c++';

-- ---valid---> since there are no rows refering to c++
delete from course where cname='c++';
