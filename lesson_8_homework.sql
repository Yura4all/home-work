--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/

select   Department, Employee, Salary  
from
    (
    select t2.name as Department, t1.name as Employee, Salary, 
    dense_rank() OVER (partition by departmentId ORDER BY salary desc) as position
    from Employee t1
    join Department t2
    on t1.departmentId=t2.id
    ) a
where position<=3

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17

select member_name, status, sum(amount*unit_price) as costs
from FamilyMembers t1
JOIN payments t2
on member_id=family_member
where year(date)=2005
group by member_name, status;

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13

select  name
from Passenger 
group by name
having count(id)>1;

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

select count(id) as count
from Student
where first_name='Anna' or middle_name='Anna'
;

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35

select count(classroom) as count
from schedule
where date='2019-09-02T00:00:00.000Z';

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

select count(id) as count
from Student
where first_name='Anna' or middle_name='Anna'
;

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32

select floor(avg(datediff(CURRENT_DATE(),birthday)/365.25))
from FamilyMembers;

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27


select good_type_name,  sum(amount*unit_price) as costs
from goods t1
JOIN payments t2
on good_id=good
join goodtypes
on type=good_type_id
where year(date)=2005
group by good_type_name;

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37

select floor(datediff(CURRENT_DATE(),max(birthday))/365.25) as year
from student;

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44


select floor(datediff(CURRENT_DATE(),min(birthday))/365.25) as max_year
from Student
where id in  
    (
    select student from student_in_class where class in 
        (
        select id from class where name like '10%'
        )
    )  
;

--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20

select member_name,status,  amount*unit_price as costs
from goods t1
JOIN payments t2
on good_id=good
join goodtypes
on type=good_type_id
join FamilyMembers
on family_member=member_id
where good_type_name ='entertainment';


--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55

with b as 
    (
    select company, max(num) as num
    from 
        (
        select company, row_number() over (partition by company) as num
        from Trip
        ) a
    group by company
    )
delete FROM company
where id in (select company from b where num = (select min(num) from b));

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45

with b as 
    (
    select classroom, count(id) num
    from schedule
    group by classroom
    )
select classroom from b where num = (select max(num) from b) ;

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43

select last_name
from teacher
where id in 
    (
    select teacher
    from schedule
    where subject in 
        (
        select id
        from Subject
        where name='Physical Culture'
        )
    )
order by  last_name         ;

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63

select name 
from
    (
    select concat(last_name,'.',first_name,'.',middle_name) as name
    from student
    ) a
order by name;
