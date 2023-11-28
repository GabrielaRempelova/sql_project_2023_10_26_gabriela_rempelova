USE engeto_2023_10_26_gabi

-- udělat dve tabulky - 1. pro jeden rok, kdy je nejnižší meziroční nárust a 2. kdy udělám pruměry pro každou
-- potravinu za všechny roky a tam kde bude nejnižší % nárust, tak ten tam dát 
-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

-- FUNKČNÍ SQL KDY VYPOČTE % NÁRUST A POKLES
SELECT 
	category_code,
	year_price,
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


SELECT 
	* 
FROM czechia_price cp 

SELECT DISTINCT  
	category_code 
FROM czechia_price cp

SELECT DISTINCT  
	YEAR(date_from) 
FROM czechia_price cp 
ORDER BY date_from;

SELECT DISTINCT  
	date_from
FROM czechia_price cp 
ORDER BY date_from;

-- udelán pruměr za celý rok pro každou potravinu, cena prumeru z cele republiky region code is null
SELECT 
	category_code,
	YEAR(date_from),
	round(avg(value))
FROM czechia_price cp 
WHERE region_code IS null
GROUP BY category_code, YEAR(date_from)
ORDER BY category_code, YEAR(date_from);


-- s použití funkce lag
SELECT 
	-- value,
	category_code,
	-- date_from,
	year(date_from) AS year,
	-- region_code 
	round(avg(value), 2) AS avg_value,
	lag (round(avg(value), 2)) OVER (PARTITION BY (category_code) ORDER BY (date_from)) AS previously_avg_value,
	round((round(avg(value), 2) - lag (round(avg(value), 2)) OVER (PARTITION BY (category_code) ORDER BY (date_from)))*100/	lag (round(avg(value), 2)) OVER (PARTITION BY (category_code) ORDER BY (date_from)), 2)
	-- round(100*((round(avg(value), 2)) - (lag (round(avg(value), 2)) OVER (PARTITION BY (category_code) ORDER BY (date_from)))/(lag (round(avg(value), 2)) OVER (PARTITION BY (category_code) ORDER BY (date_from)))), 2)
FROM czechia_price cp 
WHERE region_code IS NULL
GROUP BY category_code, year(date_from)
ORDER BY category_code, year(date_from)

100*((avg(value)) - (lag (avg(value)) OVER (PARTITION BY (category_code) ORDER BY (date_from)))/(lag (avg(value)) OVER (PARTITION BY (category_code) ORDER BY (date_from))))
round(100*((avg(value)) - (lag (avg(value)) OVER (PARTITION BY (category_code) ORDER BY (date_from)))/(lag (avg(value)) OVER (PARTITION BY (category_code) ORDER BY (date_from)))), 2)