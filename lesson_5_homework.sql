--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- Компьютерная фирма: Сделать view (pages_all_products), в которой будет постраничная разбивка всех продуктов (не более двух продуктов на одной странице). Вывод: все данные из laptop, номер страницы, список всех страниц
create view pages_all_products as
select *, row_number(*) over (partition by page order by row_number) as place
from (
	select *, floor((row_number+1)/2) as page
	from (
		SELECT *,row_number(*) over (order by model) FROM laptop
		) a
	) b;


--sample:
--1 1
--2 1
--1 2
--2 2
--1 3
--2 3

--task2 (lesson5)
-- Компьютерная фирма: Сделать view (distribution_by_type), в рамках которого будет процентное соотношение всех товаров по типу устройства. Вывод: производитель, тип, процент (%)
create view distribution_by_type as
select distinct maker, type,cast((cast((count(model) OVER(PARTITION BY type)) as NUMERIC(10,2))/(select count(model) from product)) as  NUMERIC(10,3)) as share
from  product
order by maker;
--task3 (lesson5)
-- Компьютерная фирма: Сделать на базе предыдущенр view график - круговую диаграмму. Пример https://plotly.com/python/histograms/
-- done
--task4 (lesson5) 
-- Корабли: Сделать копию таблицы ships (ships_two_words), но название корабля должно состоять из двух слов
create table ships_two_words as
select *
from ships 
where LENgth(name) - LENgth(REPLACE(name, ' ', ''))=1;
--task5 (lesson5)
-- Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL) и название начинается с буквы "S"
select name from ships
where name like'S%' and class is null
union
select ship from outcomes
where ship like'S%' and ship not in (select name from ships where class is not null);


--task6 (lesson5)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'C' и три самых дорогих (через оконные функции). Вывести model


with all_printers as 
	(
	select t1.model,t2.maker, t1.price, avg(price) OVER(PARTITION BY maker) AS aprice
	from printer t1
	join product t2
	on t1.model=t2.model	
	)
select model
from all_printers
where maker='A' and price >(select distinct aprice from all_printers where maker='C');

select model 
from (select model, price, row_number(*) OVER( ORDER BY price desc) AS position from printer) s
where position<=3;