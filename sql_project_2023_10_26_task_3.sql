USE engeto_2023_10_26_gabi

-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

-- udělat dve tabulky - 1. pro jeden rok, kdy je nejnižší meziroční nárust a 2. kdy udělám pruměry pro každou
-- potravinu za všechny roky a tam kde bude nejnižší % nárust, tak ten tam dát 

-- FUNKČNÍ SQL KDY VYPOČTE % NÁRUST A POKLES
SELECT 
	category_code,
	year_price,
	category_food_name,
	round(avg(value_food), 2) AS avg_value_food,
	round(lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)), 2) AS previously_avg_value_food,
	round((avg(value_food) - lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)))*100 / lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)), 2) AS index_percent
FROM t_gabriela_rempelova_projekt_sql_primary_final tgrpspf 
GROUP BY category_code, year_price 


-- TED VÝŠE UVEDENE ZKUSÍM SEŘADIT OD NEJMENŠÍHO - JEDNA POTRAVINA, KTERÁ MĚLA NEJNIŽŠÍ POKLES MEZIROČNÍ"
SELECT 
	category_code,
	year_price,
	round(avg(value_food), 2) AS avg_value_food,
	round(lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)), 2) AS previously_avg_value_food,
	round((avg(value_food) - lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)))*100 / lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)), 2) AS index_percent
FROM t_gabriela_rempelova_projekt_sql_primary_final tgrpspf 
GROUP BY category_code, year_price 
ORDER BY INDEX_percent

-- nejnižší nárust ceny měly dvě potraviny´= 112201 0,02% a 115201 0,02% - zkusit odstranit z index_percent hodnoty null
-- v where klauzuli to nejde, zkusit having anebo si vytvorit z toho pomocnou tabulku a tu pak spojit

CREATE TABLE t_help_task_3 AS 
(SELECT 
	category_code,
	year_price,
	round(avg(value_food), 2) AS avg_value_food,
	round(lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)), 2) AS previously_avg_value_food,
	round((avg(value_food) - lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)))*100 / lag (avg(value_food)) OVER (PARTITION BY (category_code) ORDER BY (year_price)), 2) AS index_percent
FROM t_gabriela_rempelova_projekt_sql_primary_final tgrpspf 
GROUP BY category_code, year_price 
);

DROP TABLE 



SELECT 
	category_code,	
	min(index_percent)
	-- abs(index_percent)
FROM t_help_task_3 tht
GROUP BY category_code
ORDER BY min(index_percent)

SELECT 
	category_code,
	round(avg(index_percent), 2) AS avg_index_percent
FROM t_help_task_3 tht 
WHERE index_percent IS NOT NULL 
GROUP BY category_code
ORDER BY avg(index_percent);

-- POPIS" pro každou categorii potravin, jsem udělala roční průměr ceny potraviny za celý rok. 
-- pote jsem si vytvořila pomocný sloupec ceny potraviny za předchozí rok pomocí funkce lag




