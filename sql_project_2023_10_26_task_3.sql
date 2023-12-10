-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
-- základní výpočet:
SELECT 
	category_code,
	year_price,
	category_food_name AS food_name,
	round(avg(value_food), 2) AS avg_value_food,
	round(lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)), 2) AS previously_avg_value_food,
	round((avg(value_food) - lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)))*100 / lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)), 2) AS index_percent
FROM t_gabriela_rempelova_project_sql_primary_final tgrpspf 
GROUP BY category_code, year_price, category_food_name;


-- seřazeno od nejmenšího meziročního nárustu (odpověď A a B)
SELECT 
	category_code,
	year_price,
	category_food_name AS food_name,
	round(avg(value_food), 2) AS avg_value_food,
	round(lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)), 2) AS previously_avg_value_food,
	round((avg(value_food) - lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)))*100 / lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)), 2) AS index_percent
FROM t_gabriela_rempelova_project_sql_primary_final tgrpspf 
GROUP BY category_code, year_price, category_food_name 
ORDER BY index_percent;


-- AVG index_percent za celé sledované období
CREATE TABLE t_help_task_3 AS 
(SELECT 
	category_code,
	year_price,
	category_food_name,
	round(avg(value_food), 2) AS avg_value_food,
	round(lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)), 2) AS previously_avg_value_food,
	round((avg(value_food) - lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)))*100 / lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)), 2) AS index_percent
FROM t_gabriela_rempelova_project_sql_primary_final tgrpspf 
GROUP BY category_code, year_price, category_food_name
);

DROP TABLE t_help_task_3


SELECT 
	category_code,
	category_food_name,
	round(avg(index_percent), 2) AS avg_index_percent
FROM t_help_task_3 tht 
WHERE index_percent IS NOT NULL 
GROUP BY category_code, category_food_name
ORDER BY avg(index_percent);




