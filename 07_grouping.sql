-- --------------------------
-- GROUPING

-- Group by

SELECT 
		  category_code
	FROM tbl_menu
	WHERE category_code IS NOT NULL
 GROUP BY category_code;

-- 집합 함수 걔념 도입
SELECT 
		  category_code		-- 그룹을 묶은 컬럼을 제외한 그룹함수만 가능
		, COUNT(*)				-- 그룹 함수 count
		, SUM(menu_price)
		, AVG(menu_price)
	FROM tbl_menu
	WHERE category_code IS NOT NULL
 GROUP BY category_code
 ORDER BY 2;
-- 해석: tbl_menu로부터(FROM). category_code가 not null인 것들을(WHERE). category_code로 묶어서(GROUP BY).
--		category_code와 count, sum, avg를(SELECT). count의 오름차순으로 가져온다(ORDER BY).

-- Having
SELECT 
		  category_code		
		, COUNT(*)				
		, SUM(menu_price)
		, AVG(menu_price)
	FROM tbl_menu
	WHERE category_code IS NOT NULL
 GROUP BY category_code
HAVING SUM(menu_price) >= 24000
 ORDER BY 2;
-- 해석: tbl_menu로부터(FROM). category_code가 not null인 것들을(WHERE). category_code로 묶어서(GROUP BY).
--		SUM(menu_price) >= 24000 인 것의(HAVING). category_code와 count, sum, avg를(SELECT). 
--		count의 오름차순으로 가져온다(ORDER BY).

-- 조회의 6가지 절을 모두 활용한 예제
-- 1. select: group by 절에서 group을 묶는 조건으로 활용한 컬럼만 조회 
--				또는 그룹 함수를 통해 조회한다.

-- 2. from: 테이블 또는 join을 활용한 result set을 작성한다.

-- 3. where: from 절의 각 행마다 적용될 조건을 작성한다.

-- 4. group by: where 절까지 만족하는 행들에대해 그룹이 될 컬럼을 작성한다.

-- 5. having: 그룹별로 적용할 조건을 group by에서 작성한 컬럼 
--				또는 그룹 함수를 통해 조회한다.

-- 6. order by: 제일 마지막에 해석되며 select의 결과(result set)의 순번, 별칭, 컬럼명 등으로
--			 	오름차순 또는 내림차순 한다.

SELECT 
		  category_code		
		, COUNT(*)					-- 모든 행 갯수 세기
		, COUNT(category_code)	-- category_code가 null이 아닌 행만 갯수 세기
		, SUM(menu_price)
		, AVG(menu_price)
	FROM tbl_menu
	WHERE category_code IS NOT NULL
 GROUP BY category_code
HAVING SUM(menu_price) >= 24000
 ORDER BY 2;

-- --------------------------
-- 메뉴가 없는 카테고리까지 셀것인지 구분해서 count해 보기.
SELECT 
		  COUNT(*)
		, COUNT(a.menu_name)	-- a.menu_name가 null이 아닌 행만 갯수 세기
	FROM tbl_menu a 
	RIGHT JOIN tbl_category b ON (a.category_code = b.category_code);

-- --------------------------
-- 함수의 종류
-- 단일의 함수: NVL 또는 IFNULL과 같이 단일 행마다 적용되여 행의 갯수 만큼 결과가 나오는 함수.
-- 그룹 함수: count, SUM, AVG와 같이 글븜다 적용되어 그룳의 갯수만큼 결과가 나오는 경우
-- 				(단, GROUP BY절이 없는 조회는 그룹 함수의 결과가 단일행(행 하나)이다.

-- ---------------------

-- ROLL UP
-- 중간 합계 및 최종 합계를 도출
-- group by에서 두 개 이상의 컬럼으로 그룹 형성 시 

-- 앞의 컬럼을 기준으로 중간 합계가 나오게 된다.
SELECT
		  menu_price
		, category_code
		, SUM(menu_price)
	FROM tbl_menu
  GROUP BY menu_price, category_code
   WITH ROLLUP;
   
-- ------------------------
CREATE TABLE sales (
    CODE INT AUTO_INCREMENT,		-- code는 auto increment여서 1씩 자동으로 증가. 값을 따로 넣지 않아도 입력됨.
    YEAR VARCHAR(4),
    MONTH VARCHAR(4),
    product VARCHAR(50),
    amount DECIMAL(10,2),
    PRIMARY KEY(CODE)
);

INSERT 
  INTO sales 
(
  CODE, YEAR, MONTH
, product, amount
) 
VALUES
(
  NULL, '2023', LPAD('1', 2, '0')	-- LPAD는 단일행 함수로, 매 행마다 적용할 수 있음.  LeftPAD 
, 'Product A', 1000.00					-- 첫번째 인자를 2 글자로 표현하고 싶은데 빈 공간(left)은 세번째 인자로 채우라는 뜻.
), 
(
  NULL, '2023', LPAD('1', 2, '0')
, 'Product B', 1500.00
), 
(
  NULL, '2023', LPAD('2', 2, '0')
, 'Product A', 2000.00
), 
(
  NULL, '2023', LPAD('2', 2, '0')
, 'Product B', 2500.00
), 
(
  NULL, '2023', LPAD('3', 2, '0')
, 'Product A', 1200.00
), 
(
  NULL, '2024', LPAD('3', 2, '0')
, 'Product B', 1700.00
);

SELECT * FROM sales; 

-- 연, 월, 상품명을 모두 하나의 그룹으로 묶어
-- 연, 월 중간 합계 및 전체 합계를 ROLLUP으로 구해 보자.

SELECT 
		  year
		, month
		, product
		, SUM(amount) AS total_sales
	FROM sales
  GROUP BY YEAR, MONTH, product
   WITH ROLLUP;

DELETE
	FROM sales
  WHERE CODE >=7; -- 단, 이러면 auto_increment 값을 다시 조정해야함.


