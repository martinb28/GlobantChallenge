USE globant
GO
--1)
SELECT
	d.department,
	j.job,
	SUM(CASE WHEN CONVERT(DATE,he.hire_date,127) >= '2021-01-01' AND CONVERT(DATE,he.hire_date,127) < '2021-04-01' THEN 1 ELSE 0 END) as Q1,
	SUM(CASE WHEN CONVERT(DATE,he.hire_date,127) >= '2021-04-01' AND CONVERT(DATE,he.hire_date,127) < '2021-07-01' THEN 1 ELSE 0 END) as Q2,
	SUM(CASE WHEN CONVERT(DATE,he.hire_date,127) >= '2021-07-01' AND CONVERT(DATE,he.hire_date,127) < '2021-10-01' THEN 1 ELSE 0 END) as Q3,
	SUM(CASE WHEN CONVERT(DATE,he.hire_date,127) >= '2021-10-01' AND CONVERT(DATE,he.hire_date,127) < '2021-12-01' THEN 1 ELSE 0 END) as Q4
FROM hired_employees he
INNER JOIN jobs j
	ON he.job_id = j.id
INNER JOIN departments d
	ON he.department_id = d.id
GROUP BY j.job, d.department
ORDER BY d.department, j.job ASC;

--2)
--Create CTE DepartmentAverages to calculate avg employees hired in every department in 2021
WITH DepartmentAverages AS (
    SELECT
        department_id,
        AVG(COUNT(id)) OVER () AS average_hires
    FROM hired_employees
    WHERE YEAR(CAST(hire_date AS DATE)) = 2021
    GROUP BY department_id
),
--create CTE DepartmentHires to calculate how many employees were hired in 2021 for every department
DepartmentHires AS (
    SELECT
        d.id AS department_id,
        d.department,
        COUNT(he.id) AS num_hires
    FROM departments d
    INNER JOIN hired_employees he 
		ON d.id = he.department_id
    WHERE YEAR(CAST(he.hire_date AS DATE)) = 2021
    GROUP BY d.id, d.department
)
--using both CTE to build a query to get the final result
SELECT
    dh.department_id,
    dh.department,
    dh.num_hires
FROM DepartmentHires dh
INNER JOIN DepartmentAverages da
	ON dh.department_id = da.department_id
WHERE dh.num_hires > da.average_hires
ORDER BY dh.num_hires DESC;