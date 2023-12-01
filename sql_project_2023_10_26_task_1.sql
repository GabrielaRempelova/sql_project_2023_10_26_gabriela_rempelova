SELECT 
	industry_branch_code,
	name,
	payroll_year,
	round(avg(value_salary), 2) AS avg_value_salary,
	lag(avg(value_salary)) OVER (PARTITION BY (industry_branch_code) ORDER BY (payroll_year)) AS previously_salary,
	round(100*(avg(value_salary) - lag(avg(value_salary)) OVER (PARTITION BY (industry_branch_code) ORDER BY (payroll_year)))/lag(avg(value_salary)) OVER (PARTITION BY (industry_branch_code) ORDER BY (payroll_year)), 2) AS index_percent
FROM t_gabriela_rempelova_projekt_sql_primary_final tgrpspf 
WHERE industry_branch_code IS NOT null
GROUP BY industry_branch_code, payroll_year
ORDER BY industry_branch_code, payroll_year;