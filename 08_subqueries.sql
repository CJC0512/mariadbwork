-- -------------------
-- Subqueries
-- 다른 쿼리 내에서 실행되는 쿼리를 뜻 함.
-- subquery의 결과를 활용해서 복잡한 mainquery를 작성해 한번에 여러 작업을 수행 할 수 있다.
-- => 다른 문제를 해결해서 만든 조회 결과를 바탕으로 조회가 가능하다는 의미??

-- practice - employee 과제 db(employeedb)에서 실행해 볼 것
-- 유재식씨의 부서와 같은 부서에서 일하는 직원
SELECT * FROM employee;

-- subquery
SELECT dept_code FROM employee WHERE emp_name = '유재식'; -- D6

-- mainquery
SELECT * FROM employee WHERE dept_code = 'D6'; -- 유재식씨와 같은 부서에 일하는 직원(본인 포함)

-- subquery를 포함한 mainquery
SELECT 		-- mainquery에서는 select 다음 행부터 적기
		  *
	FROM employee
  WHERE dept_code = (SELECT dept_code		-- subquery에서는 select 옆에서부터 적기
  							  FROM employee
  							 WHERE emp_name = '유재식');

-- 이와 같은 방법으로 유재식씨 사원번호를 추출해서 해당 사원을 제거해 보자.
SELECT 
		 *
  FROM employee
 WHERE dept_code = (SELECT dept_code
 							 FROM employee
 							WHERE emp_name = '유재식')
 	AND emp_id <> (SELECT emp_id
 						  FROM employee
 						 WHERE emp_name = '유재식');

-- 결국엔 조회한 결과 select ~~ from 한 것이 subquery이고 이걸 조회에 활용하면 subquery를 활용한 조회.
-- subquery는 from 다음에 위치할 수 도 있고(=인라인 뷰), where의 조건문에도 비교자로 위치할 수 있다. 
-- subquery 또한 별칭이 가능하다. as 

-- ------------------------------
-- 상관 서브쿼리
-- 메인 쿼리가 서브쿼리의 결과에 영향을 주는 경우 상관 서브쿼리라고 한다.
-- SUBQUERY를 활용해 카테고리별 평균 가격보다 높은 가격의 메뉴 조회
-- 서브 쿼리가 메인 쿼리를 참조해서 결과를 도출할 경우 상관 서브쿼리?

-- 메뉴 조회시 메뉴의 카테고리에 있는 메뉴들의 평균 가격보다 높은 메뉴만 조회.
-- 상관 서브쿼리 및 단일행 서브쿼리 사용
SELECT 
		  a.menu_code
		, a.menu_name
		, a.menu_price
		, a.category_code
		, a.orderable_status
 	FROM tbl_menu a
  WHERE a.menu_price > (SELECT AVG(b.menu_price)
  								  FROM tbl_menu b
  								 WHERE b.category_code = a.category_code);


-- 메뉴 카테고리의 평균과 똑같은 가격의 메뉴 조회. 
-- 상관 서브쿼리를 안 쓰고 다중행 서브쿼리를 사용.
SELECT 
		  *
	FROM tbl_menu a
  WHERE a.menu_price IN (SELECT AVG(b.menu_price)
  								  FROM tbl_menu b
  								GROUP BY b.category_code);
								-- where menu_price in (4000, 5000, 6000); 같은 느낌

-- -----------------------------------
-- exists
-- 조회 결과가 있으면 True, 없으면 False

-- 메뉴가 있는 카테고리를 조회
SELECT 
		  a.category_code
		, a.category_name
	FROM tbl_category a
  WHERE EXISTS(SELECT 1
  					  FROM tbl_menu b
  					 WHERE b.category_code = a.category_code)
  ORDER BY 1;
-- 해석) exists(select ~ 문을 통해 a와 b의 category_code가 일치하는 항목만 조회한다.
-- 		where 문을 통해 존재하는 항목들만 select 되어 조회되는데, 
-- 		이때, order by문에 의하여 category_code의 오름차순으로 조회된다.

-- 4번 카테고리를 메인 쿼리에서 where 조건 판별 중 동작하는 서브쿼리  
SELECT 1
  FROM tbl_menu b
 WHERE b.category_code = 4;

-- join을 활용한 메뉴가 있는 카테고리 조회도 해보자.
SELECT 
		  a.category_code
		, a.category_name
	FROM tbl_category a
	JOIN tbl_menu b ON (a.category_code = b.category_code)
 GROUP BY a.category_code, a.category_name
 ORDER BY 1;
-- 해석) Join 문에서 a와 b의 category_code를 기준으로 join한다.
-- 		거기서 a의 category_code와 category_name을 기준으로 Group by하여 중복을 없애고 합친다.
--			조건에 부합하는 a의 category_code와 category_name을 가져와
--			order by 문을 통해 category_code의 오름차순으로 조회한다.

-- 심심문제(practice-employeedb)
-- 1. 가장 높은 급여를 받는 사원 조회하기(MAX(컬럼명))
SELECT 
		  a.emp_id
		, a.emp_name
		, a.salary
	FROM employee a
  WHERE a.salary = (SELECT MAX(b.salary)
							 FROM employee b);
							 
-- 2. 평균 급여가 가장 높은 부서 조회하기(AVG(컬럼명), MAX(컬럼명))

-- i) 이중 서브쿼리를 사용한 방법
SELECT 
		  a.dept_code
	FROM employee a
  GROUP BY a.dept_code 
  HAVING AVG(a.SALARY) = (SELECT  MAX(c.avg_sal) 
  									 FROM (SELECT AVG(b.salary) as avg_sal
											   FROM employee b
											   GROUP BY b.dept_code) AS C);
											   
-- 해석) 평균 급여가 가장 높은 부서를 조회하기 위해서는 부서를 기준으로 그룹을 구성해줘야한다.
-- 따라서 서브쿼리와 메인 쿼리 모두 dept_code를 기준으로 grouping 해준다.
-- 다음으로 평균 급여의 최댓값을 구해야하는데, 평균 급여는 avg(salary)를 통해 구해준다.
-- 구해놓은 서브 쿼리를 C로 별칭하여 C로부터 avg(b.salary)의 별칭 avg_sal을 가져와, 
-- 최댓값을 가져오는 서브쿼리를 새로 작성한다.
-- 이 서브쿼리의 요소로 평균 급여의 최댓값이 나온다.
-- 메인 쿼리로 employee에서 구한 급여의 평균이 마지막 서브쿼리의 결과값과 동일하는 것을 조회하는 연산을 작성한다.

-- ii) >= ALL을 활용한 방법
-- 서브쿼리 중에 다중행 서브쿼리인 경우에는 비교 연산자가 일반 비교연산자와 달라진다.
-- > ALL, < ALL, > ANY, < ANY, IN
-- 1. > ALL: 모든 서브쿼리 결과보다 크다.(서브쿼리의 최대값보다 크다)
-- 2. < ALL: 모든 서브쿼리 결과보다 작다.(서브쿼리의 최소값보다 작다)
-- 3. > ANY: 서브쿼리 결과 보다 최소 하나보다는 크다.(서브쿼리의 최소값보다 크다)
-- 4. < ANY: 서브쿼리 결과 보다 최대 하나보다는 작다.(서브쿼리의 최대값보다 작다)
-- 5. IN: 서브쿼리 결과 중에 하나라도 일치한다.

SELECT 
		  dept_code
	FROM employee
  GROUP BY dept_code
 HAVING AVG(salary) >= ALL(SELECT AVG(salary)
 								  FROM employee
 								 GROUP BY dept_code)


-- -------------------------
-- CTE(Common Table Expressions)
-- 인라인뷰로 쓰인 서브쿼리(FROM 절에 쓰인 서브쿼리)를 미리 정의하는 것
-- 메인 쿼리가 심플해 질 수 있도록 도와줌.

WITH menucate AS (
    SELECT menu_name
         , category_name
      FROM tbl_menu a
      JOIN tbl_category b ON a.category_code = b.category_code
)
SELECT
       *
  FROM menucate
 ORDER BY menu_name;