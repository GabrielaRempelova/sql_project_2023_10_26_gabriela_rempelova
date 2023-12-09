--  ÚKOL 2 
-- Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období 
-- v dostupných datech cen a mezd?

-- 114201 - mleko
-- 111301 - chleba


-- SALARY - avg/year:
DROP TABLE t_avg_value_salary

CREATE TABLE t_avg_value_salary AS
(
	SELECT 
		payroll_year,
		round(avg(value_salary), 2) AS avg_value_salary
	FROM t_gabriela_rempelova_project_sql_primary_final tgrpspf 
	WHERE industry_branch_code IS NOT null
	GROUP BY payroll_year
);

-- MILK - avg/year:
DROP TABLE t_avg_value_food_milk

CREATE TABLE t_avg_value_food_milk AS
(
	SELECT 
		year_price,
		round(avg(value_food), 2) AS avg_value_food_milk
	FROM t_gabriela_rempelova_project_sql_primary_final tgrpspf 
	WHERE category_code = 114201
	GROUP BY year_price 
);

-- BREAD - avg/year:
DROP TABLE t_avg_value_food_bread

CREATE TABLE t_avg_value_food_bread AS
(
	SELECT 
		year_price,
		round(avg(value_food), 2) AS avg_value_food_bread
	FROM t_gabriela_rempelova_project_sql_primary_final tgrpspf 
	WHERE category_code = 111301
	GROUP BY year_price 
);

-- JOIN:
SELECT 
	tavs.payroll_year,
	tavs.avg_value_salary,
	tavfm.avg_value_food_milk,
	round(tavs.avg_value_salary/tavfm.avg_value_food_milk) AS pieces_milk_year,
	tavfb.avg_value_food_bread,
	round(tavs.avg_value_salary/tavfb.avg_value_food_bread) AS pieces_bread_year
FROM t_avg_value_salary tavs 
JOIN t_avg_value_food_milk tavfm  
	ON tavs.payroll_year = tavfm.year_price 
JOIN t_avg_value_food_bread tavfb 
	ON tavs.payroll_year = tavfb.year_price;

