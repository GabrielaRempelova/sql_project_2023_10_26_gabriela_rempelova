/*Má výška HDP vliv na změny ve mzdách a cenách potravin? 
Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách 
ve stejném nebo násdujícím roce výraznějším růstem?
*/

-- vytvorena tbl_secondary_final - final
SELECT 
	a2.country,
	a2.YEAR,
	a2.gdp,
	a2.index_gdp,
	-- tavs.avg_value_salary,
	round(tavs.index_perc_avg_value_salary, 2) AS index_salary,
	round(tavfi.index_avg_value_food_year, 2) AS index_food
FROM t_gabriela_rempelova_project_sql_secondary_final a2 
JOIN t_avg_value_salary_index tavs 
	ON tavs.payroll_year =a2.year 
JOIN t_avg_value_food_index tavfi
	ON tavfi.year_price = a2.`year`
WHERE country = "Czech Republic";