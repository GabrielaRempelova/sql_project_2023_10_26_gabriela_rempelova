-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

-- tabulka jiy vytvorena v otazce c. 2 - PRUMERNA MZDA ZA KAZDY ROK
SELECT 
	*
FROM t_avg_value_salary;

-- doplneno o index - procento mezirocniho srovnani (je mozne doplnit jiz do puvodni tbl, ale vytvorila jsem novou)
DROP TABLE t_avg_value_salary_index

CREATE TABLE t_avg_value_salary_index
(	
	SELECT 
		tavs.*,
		lag(avg_value_salary) OVER (ORDER BY (payroll_year)) AS avg_value_salary_prev_year,
		(avg_value_salary - lag(avg_value_salary) OVER ( ORDER BY (payroll_year)))*100/lag(avg_value_salary) OVER ( ORDER BY (payroll_year)) AS index_perc_avg_value_salary
	FROM t_avg_value_salary tavs 
);

-- Tabulka prumerne ceny potravin za rok
DROP TABLE t_avg_value_food_index

CREATE TABLE t_avg_value_food_index
(
SELECT 
		year_price,
		avg(value_food) AS avg_value_food,
		lag(avg(value_food)) OVER (ORDER BY (avg(year_price))) AS avg_value_food_prev_year,
		(avg(value_food) - lag(avg(value_food)) OVER (ORDER BY (avg(year_price))))*100/lag(avg(value_food)) OVER (ORDER BY (avg(year_price))) AS index_avg_value_food_year
	FROM t_gabriela_rempelova_project_sql_primary_final tgrpspf 
	GROUP BY year_price 
);


SELECT 
	tavsi.*,
	tavfi.avg_value_food,
	tavfi.avg_value_food_prev_year,
	round(tavfi.index_avg_value_food_year, 2) AS index_avg_value_food,
	round(tavfi.index_avg_value_food_year - tavsi.index_perc_avg_value_salary, 2) AS difference_index
FROM t_avg_value_salary_index tavsi 
JOIN t_avg_value_food_index tavfi 
	ON tavsi.payroll_year = tavfi.year_price
ORDER BY tavsi.payroll_year; 


