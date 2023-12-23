-- ----------------------------------
-- where 절 (유사 조건문, 비교연산자 사용 가능)

-- orderable_status = 'N'인 행들 조회하기
-- 주문 불가능한 메뉴 조회(메뉴얼, 메뉴코드) 
SELECT 
		  menu_name
		, menu_price
		, orderable_status
	FROM tbl_menu
 WHERE orderable_status = 'N';

-- DESC(=describe)를 통한 컬럼명 빠르게 확인 
DESC tbl_menu;
 
 
-- -------------------------------
-- 1) '기타' 카테고리의 번호 파악하기
DESC tbl_category;
-- SELECT * FROM tbl_category;
SELECT * FROM tbl_category WHERE category_name = '기타';

-- 2)) 해당 번호를 가지지 않는 메뉴 조회
DESC tbl_menu;
-- SELECT *FROM tbl_menu;
SELECT *	FROM tbl_menu WHERE category_code = 10;
SELECT *	FROM tbl_menu WHERE category_code <> 10; -- != 와 <> 는 같은 의미

-- --------------------------------
-- 가격이 10,000원 이상의 메뉴 조회 
SELECT * FROM tbl_menu WHERE menu_price >= 10000;

-- 가격이 10,000원 미만의 메뉴 조회
SELECT * FROM tbl_menu WHERE menu_price < 10000;

-- 가격이 10,000원 이상 12,000원 이하 메뉴 조회
SELECT 
			* 
	FROM tbl_menu 
 WHERE menu_price >= 10000 
	AND menu_price <= 12000;

SELECT
			 * 
	FROM tbl_menu 
 WHERE menu_price >= 10000 && menu_price <= 12000;

-- &을 한번만 쓰면 가격이 10,000원 이상인 메뉴와 12,000원 이하인 메뉴 조회가 된다.
SELECT
			 * 
	FROM tbl_menu 
 WHERE menu_price >= 10000 & menu_price <= 12000;
 

-- 논리 연산자(= 참과 거짓의 연산)
-- 사랑스런 조카가 타고싶은 롤러 코스터는 7세 이상, 100cm 이상만 가능
-- (and, 둘다 만족, 이면서, 그리고, 동시에)
SELECT 
		  *
	FROM nephew
 WHERE age >= 7
 	AND height >= 100;

-- 내 친구는 콜라도 좋아하고 사이다도 상관 없다.(콜라 또는 사이다)
SELECT 
		  *
	FROM friend
 WHERE drink = 'coke' 
 	OR drinks = 'sprite';
 	

-- ------------------------------
-- whrer and or 활용 예제
SELECT
		  menu_code
		, menu_name
		, menu_price
		, category_code
		, orderable_status
	FROM tbl_menu
 WHERE menu_price > 5000
 	AND category_code = 10;
 	

SELECT
		  menu_code
		, menu_name
		, menu_price
		, category_code
		, orderable_status
	FROM tbl_menu
 WHERE menu_price > 5000
 	OR category_code = 10;
 	
-- ---------------------------
-- between 연산자 활용하기
-- 가격이 5000원 이상 9000원 이하인 메뉴 전체 컬럼 조회
SELECT
		  *
	FROM tbl_menu
  WHERE menu_price >= 5000
  	 AND menu_price <= 9000;
  	 
SELECT 
		  *
	FROM tbl_menu
  WHERE menu_price BETWEEN 5000 AND 9000;
  
-- 반대의 범위로 테스트하자
SELECT 
		  *
	FROM tbl_menu
  WHERE menu_price < 5000
  	  OR menu_price > 9000;
  	  
SELECT 
		  *
	FROM tbl_menu
  WHERE NOT menu_price BETWEEN 5000 AND 9000;

SELECT 
		  *
	FROM tbl_menu
  WHERE menu_price NOT BETWEEN 5000 AND 9000;
  
  
-- -----------------------
-- like 연산자 (=포함한다, 내용에 따른 참조)
-- 메뉴 이름에 '밥'이 들어간 메뉴 조회

SELECT 
		  *
	FROM tbl_menu
  WHERE menu_name LIKE '%밥%';
-- 앞뒤로 % 기호를 붙이는 이유?
-- MariaDB는 내가 찾고자하는 단어가 포함된 것을 검색하려면 앞뒤로 %를 붙여줘야함.

-- 메뉴 이름에 '밥'이 안들어간 메뉴 조회
SELECT 
		  *
	FROM tbl_menu
  WHERE menu_name NOT LIKE '%밥%';
-- WHERE NOT menu_name LIKE '%밥%'; 도 가능.

-- like는 사이트에서 작성자, 제목, 작성자+제목에 따른 검색을 구현할 때 사용된다.

-- ------------------------------
-- in 연산자

SELECT 
		  *
	FROM tbl_category;
	
-- or을 활용한 '중식', '커피', '기타' 카테고리의 메뉴 조회하기
SELECT 
		  *
	FROM tbl_menu
  WHERE category_code = 5 -- 중식
  	  OR category_code = 8 -- 커피
  	  OR category_code = 10; -- 기타
  	  
-- in 연산자 활용

SELECT 
		  *
	FROM tbl_menu
  WHERE category_code IN (5, 8, 10);

-- -------------------------
-- is null 연산자 활용

-- ref_category_code(상위 카테고리 번호)가 없는 카테고리 조회
SELECT 
		  *
	FROM tbl_category
  WHERE ref_category_code IS NULL;

-- 반대도 해보자.
SELECT
		  *
	FROM tbl_category
  WHERE ref_category_code IS NOT NULL;
-- WHERE not ref_category_code IS NULL; 도 가능하다.

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

-- ----------------------
-- limit







  
-- -------------------
-- 개인 궁금증
SELECT 
		  *
	FROM tbl_menu
ORDER BY menu_code;

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
  WHERE menu_price <= 8000
  	  OR category_code = 10
  	 AND category_code = 12
  	  ORDER BY menu_code;
 	  
SELECT 
		  *
	FROM tbl_menu
  WHERE (menu_price <= 8000
  	 AND category_code = 10)
  	  OR category_code = 12
  	  ORDER BY menu_code;
