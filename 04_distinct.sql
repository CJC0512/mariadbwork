-- -----------------------
-- distinct 연산자
-- 중복된 값을 제거하는데 사용. 
-- 컬럼에 있는 컬럼값들의 종류를 쉽게 파악할 수 있다.
-- NULL도 하나의 종류로 인식
-- 예) 메뉴가 존재하는 카테고리의 종류를 뽑을 때, Distinct를 쓸 수 있다.
SELECT 
		  DISTINCT category_code
--	,	  menu_name 
	FROM tbl_menu
 ORDER BY category_code;
-- 주석된 3행이 추가될 경우 distinct 보다 menu_name을 조회하는 것이 우선순위가 높아 menu_name을 전부 출력한다.
-- 결국 distinct가 무의미해지는 결과.

-- null 값을 포함한 컬럼의 distinct
SELECT
		  DISTINCT ref_category_code
	FROM tbl_category;

-- null 을 나중으로 보내는 정렬
SELECT 
		  DISTINCT ref_category_code
	FROM tbl_category
 ORDER BY 1 DESC;

SELECT 
			DISTINCT ref_category_code AS 'rcc'
	FROM tbl_category
  ORDER BY -rcc DESC;

-- 기본 정렬의 개념(순번이나 별칭을 사용하지 않고는 정렬할 수 없다.)은 syntax에러(론법 에러)가 발생한다.
SELECT 
		  DISTINCT ref_category_code
	FROM tbl_category
 ORDER BY 'ref_category_code' DESC;
-- ORDER BY DISTINCT 'ref_category_code DESC; -- 에러 발생

-- 컬럼 두개 이상도 distinct로 묶을 수는 있지만 좋은 형태는 아니다.
-- 컬럼 두개 이상부터는 이후 배울 group by절을 통해 중복 제거를 하자.
SELECT
		  DISTINCT category_code, orderable_status -- 이 두 개를 하나의 그룹으로 인식
	FROM tbl_menu;

  
-- -------------------
-- 개인 궁금증
SELECT 
		  *
	FROM tbl_menu
ORDER BY menu_price;

SELECT 
		  *
	FROM tbl_menu
  WHERE menu_price <= 8000
  	 AND (category_code = 10
  	  OR category_code = 12)
  	  ORDER BY menu_code;

SELECT 
		  *
	FROM tbl_menu
  WHERE category_code = 12
  	 OR (menu_price <= 8000
  	  AND category_code = 10)
  	  ORDER BY menu_code;
  	
SELECT 
		  *
	FROM tbl_menu
  WHERE menu_price <= 8000
  	 AND category_code = 10
  	  OR category_code = 12
  	  ORDER BY menu_code;

SELECT 
		  *
	FROM tbl_menu
  WHERE menu_price <= 8000 OR (category_code = 10 AND category_code = 12)
  	  ORDER BY menu_code;
 	  
SELECT 
		  *
	FROM tbl_menu
  WHERE menu_price <= 8000 -- OR (category_code = 10 AND category_code = 12)
  	  ORDER BY menu_code; 	  
 	  
SELECT 
		  *
	FROM tbl_menu
  WHERE (menu_price <= 8000
  	 AND category_code = 10)
  	  OR category_code = 12
  	  ORDER BY menu_code;


-- ----------------
SELECT
		  SUM(menu_price) AS 'sum'
	FROM tbl_menu
	GROUP BY category_code
	ORDER BY tbl_menu;
