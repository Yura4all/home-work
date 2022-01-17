--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7). В таблицу table1 записать 1000 строк с случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/
select email
FROM person
GROUP BY  email
HAVING COUNT(*) > 1 ;
--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/
select name as Employee
from employee
where id in 
    (
    select t1.id from employee t1 join employee t2 on t1.managerid=t2.id
    where t1.salary>t2.salary
    ) 
;
--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/
select  score, dense_RANK() OVER(order by score  desc) as  'rank'
from scores
;

--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/
select firstName,lastName,city, state 
from person t1
left join address t2
on t1.personId=t2.personId;
