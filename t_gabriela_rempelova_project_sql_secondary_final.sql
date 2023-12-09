DROP TABLE t_gabriela_rempelova_project_sql_secondary_final 

CREATE TABLE t_gabriela_rempelova_project_sql_secondary_final 
(
	SELECT 
		c.country,
		e.year,
		e.gini,
		e.population,
		e.gdp,
		lag(e.gdp) OVER (PARTITION BY (country) ORDER BY (year)) AS gdp_prev,
		round((e.gdp - lag(e.gdp) OVER (PARTITION BY (country) ORDER BY (year)))*100/lag(e.gdp) OVER (PARTITION BY (country) ORDER BY (year)), 2) AS index_gdp
		FROM countries c
	JOIN economies e 
		ON c.country = e.country 
	JOIN t_avg_value_salary_index tavs 
		ON tavs.payroll_year =e.year 
	JOIN t_avg_value_food_index tavfi
		ON tavfi.year_price = e.year
	WHERE c.continent = "Europe"
		AND e.year BETWEEN 2006 AND 2018
	ORDER BY c.country, e.year
);

