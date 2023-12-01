USE engeto_2023_10_26_gabi

-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

-- tabulka jiy vytvorena v otazce c. 2 - PRUMERNA MZDA ZA KAZDY ROK
SELECT 
	*
FROM t_avg_value_salary

-- doplneno o index - procento mezirocniho srovnani (je mozne doplnit jiz do puvodni tbl, ale vytvorila jsem novou)
DROP TABLE t_avg_value_salary_index_task_4

CREATE TABLE t_avg_value_salary_index_task_4
(	
	SELECT 
		tavs.*,
		lag(avg_value_salary) OVER (ORDER BY (payroll_year)) AS avg_value_salary_prev_year,
		(avg_value_salary - lag(avg_value_salary) OVER ( ORDER BY (payroll_year)))*100/lag(avg_value_salary) OVER ( ORDER BY (payroll_year)) AS index_perc_avg_value_salary
	FROM t_avg_value_salary tavs 
);

-- Tabulka prumerne ceny potravin za rok
DROP TABLE t_avg_value_food_year_index_task_4

CREATE TABLE t_avg_value_food_year_index_task_4
(
SELECT 
		year_price,
		avg(value_food) AS avg_value_food,
		lag(avg(value_food)) OVER (ORDER BY (avg(year_price))) AS avg_value_food_prev_year,
		(avg(value_food) - lag(avg(value_food)) OVER (ORDER BY (avg(year_price))))*100/lag(avg(value_food)) OVER (ORDER BY (avg(year_price))) AS index_avg_value_food_prev_year
	FROM t_gabriela_rempelova_projekt_sql_primary_final tgrpspf 
	GROUP BY year_price 
);


SELECT 
	tavsit.*,
	tavfyit.avg_value_food,
	tavfyit.avg_value_food_prev_year,
	tavfyit.index_avg_value_food_prev_year,
	tavfyit.index_avg_value_food_prev_year - tavsit.index_perc_avg_value_salary AS difference_index
FROM t_avg_value_salary_index_task_4 tavsit 
JOIN t_avg_value_food_year_index_task_4 tavfyit 
	ON tavsit.payroll_year = tavfyit.year_price
ORDER BY tavsit.payroll_year 


