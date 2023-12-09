
CREATE TABLE t_gabriela_rempelova_project_sql_primary_final AS 
(
	SELECT 
		cp.value AS value_salary,
		cp.value_type_code,
		cp.industry_branch_code,
		cpib.name,
		cp.payroll_year,
		cp.payroll_quarter,
		cp2.value AS value_food,
		cp2.category_code,
		cpc.name AS category_food_name,
		YEAR(cp2.date_from) AS year_price,
		cp2.region_code
	FROM czechia_payroll cp 
		JOIN czechia_price cp2 
			ON cp.payroll_year = year(cp2.date_from)
			AND cp2.region_code IS NULL 
		JOIN czechia_payroll_industry_branch cpib 
			ON cp.industry_branch_code = cpib.code 
		JOIN czechia_price_category cpc 
			ON cpc.code = cp2.category_code
	WHERE cp.value_type_code = 5958
	ORDER BY cp.payroll_year ASC 
);

DROP table t_gabriela_rempelova_project_sql_primary_final

