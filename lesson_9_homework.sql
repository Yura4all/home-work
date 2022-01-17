--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

 select  name, grade , marks
 from
    (
    select *, row_number() OVER (ORDER BY grade DESC, name) as filter 
    from 
        (   
        select name, marks,
        ceiling(marks/10) as grade
        from students
        where ceiling(marks/10)>=8
        ) a
    union all
    select *, row_number() OVER (ORDER BY grade DESC, marks asc) as filter 
    from 
        (   
        select 'Null', marks, ceiling(marks/10) as grade
        from students
        where ceiling(marks/10)<8
        ) a2
    ) b
;


--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem

select Doctor, Professor, Singer, Actor
from
(select  name as Doctor, row_number() OVER (ORDER BY name) num
from OCCUPATIONS
where occupation='Doctor') t1

right join
(select  name as Professor, row_number() OVER (ORDER BY name) num
from OCCUPATIONS
where occupation='Professor') t2
on t1.num=t2.num

left join
(select  name as Singer, row_number() OVER (ORDER BY name) num
from OCCUPATIONS
where occupation='Singer') t3
on t2.num=t3.num

left join
(select  name as Actor, row_number() OVER (ORDER BY name) num
from OCCUPATIONS
where occupation='Actor') t4
on t2.num=t4.num
;

--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem

select distinct city
from station
where lower(substr(city,1,1)) not in ('a','e','i','o','u') 
;

--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem

select distinct city
from station
where lower(substr(city,length(city),1)) not in ('a','e','i','o','u') 
;

--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem

select distinct city
from station
where 
    lower(substr(city,length(city),1)) not in ('a','e','i','o','u') 
    or
    lower(substr(city,1,1)) not in ('a','e','i','o','u') 
;

--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem

select distinct city
from station
where 
    lower(substr(city,length(city),1)) not in ('a','e','i','o','u') 
    and
    lower(substr(city,1,1)) not in ('a','e','i','o','u') 
;


--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem

select name
from Employee
where salary >2000 and months<10
order by employee_id;

--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
