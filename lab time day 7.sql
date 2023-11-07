use acts0923;

select distinct e1.* from emp e1 join emp e2 on e1.EMPNO = e2.mgr where e1.SAL > 1500 order by e14.ename;

select distinct e.* from emp e, emp e1 where e1.mgr = e.empno order by e.ename;

select empno, ename from emp where empno in (select distinct mgr from emp) order by ename;

SELECT e.*
FROM emp e, emp e1
WHERE e1.mgr = e.empno
ORDER BY e.ename;

select * from emp e left join dept d on d.deptno = e.deptno;

select e.*,'|',d.* from emp e right join dept d on d.deptno = e.deptno;

select e.*,'|',d.* from student e right join student_marks d on e.sid=d.sid;

 select e.sid ,e.sname,'|',sum(d.marks) from student e left join student_marks d on e.sid=d.sid group by e.sid order by 4 desc;
 
 select * from room r , course c where r.rid=c.roomid;
 
 select * from faculty r , course c where r.fid=c.facid;
 