-- 1. 각 부서별로 평균 급여를 구해, employee table에 join 하시오.
DESC employee;

WITH avg_table AS
(
SELECT 
		  b.dept_code
		, AVG(b.salary) 'avg_sal'
	FROM employee b
 GROUP BY b.dept_code
)

SELECT
		  *
	FROM employee a
 	left JOIN avg_table b ON (a.dept_code = b.dept_code)
  ORDER BY a.emp_id;
-- --------------
-- NVL 처리를 할 경우
WITH avg_table AS
(
SELECT 
		  NVL(b.dept_code, 'D0') 'D_code'
		, AVG(b.salary) 'avg_sal'
	FROM employee b
 GROUP BY b.dept_code
)

SELECT
			*
-- 		  a.dept_code
		, NVL(a.dept_code, 'D0') 'D_c11111'	-- 여기서 각 행별로 알맞게 정렬되지 않음.  
		-- update 또는 replace로 employee 자체를 수정해야 null값인 항목에 접근 가능
	FROM employee a
 	left JOIN avg_table b ON (a.dept_code = b.D_code)
  ORDER BY a.emp_id;
  
-- SELECT
-- 		  *
-- 	FROM employee a
--  	left JOIN (SELECT b.dept_code 
-- 				  , AVG(b.salary) 'avg_sal'
-- 		  	  FROM employee b
--  			GROUP BY b.dept_code) b ON (a.dept_code = b.dept_code)
--   ORDER BY a.emp_id;
  


-- 2. employeedb에서 평균 급여가 제일 낮은 부서를 조회하시오.
--