select date_sub(date_sub('2014-09-03',interval 3 month), interval day('2014-09-03')-1 day);

-- select date_sub('2014-09-03', interval day('2014-09-03')-1 day);

select date_sub(date_sub('2014-09-03',interval 2 month), interval day('2014-09-03') day);


-- select hiredate from emp group by hiredate having dayname(hiredate) = 'thursday';

select distinct hiredate from emp where dayname(hiredate)='thursday';

select date_sub(date_sub('2014-09-03',interval month('2014-09-03')-1 month), interval day('2014-09-03')-1 day);

SELECT MAKEDATE(YEAR(CURDATE()), 1);

select date_sub(MAKEDATE(YEAR(CURDATE())+1, 1),interval 1 day);

SELECT TIMESTAMPDIFF(day, '2001-09-03', CURDATE()) AS Age;





 