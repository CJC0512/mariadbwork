-- -----------------
-- join (=inner join)
-- 관계(=같은 개념의 컬럼)가 있으면 함께 조회할 수 있다.
-- 관계를 거쳐나가 다른 테이블의 컬럼을 사용할 수 있다. 

SELECT 
		  *
	FROM tbl_menu a 
	JOIN tbl_category b  
	ON a.category_code = b.category_code;

-- 해석) tbl_menu의 category_code와 tbl_category의 category_code를 기준으로 tbl_menu와 tbl_category를 병합한다.	

-- JOIN 하기 전에 사용하려는 테이블을 먼저 확인하고 진행하는 것이 좋다.
SELECT
		  *
	FROM tbl_menu;
	
SELECT
		  *
	FROM tbl_category;
	
-- 메뉴명과 카테고리명만 조합
SELECT 
			menu_name
		,	category_name
	FROM tbl_menu
	JOIN tbl_category ON (tbl_menu.category_code = tbl_category.category_code);
	
-- 테이블명도 별칭(alias)을 붙일 수 있다.
SELECT 
			menu_name
		,	category_name
	FROM tbl_menu a
	JOIN tbl_category b ON (a.category_code = b.category_code);
	
-- 두 테이블에 같은 컬럼명이 있는 상태에서 JOIN 시 주의할 점
-- 1.
SELECT 
			menu_name
		,	category_name
	FROM tbl_menu a
	JOIN tbl_category b ON (category_code = category_code); -- ambiguous error
-- 두 컬럼명이 다르다면 ambiguous error 발생 X
-- 두 컬럼명이 같다면 별칭 필수

-- 2.
SELECT
			menu_name
		,	category_name
		,	category_code	-- select절도 동일한 컬럼은 별칭을 필수로 달아야 한다.
	FROM tbl_menu a
	JOIN tbl_category b ON (a.category_code = b.category_code);
-- 관례상 JOIN시에는 쿼리에 사용되는 모든 컬럼에 별칭을 다는 것을 원칙으로 한다.

-- 좋은 예) 모든 컬럼에 별칭을 담
SELECT
			a.menu_name
		,	b.category_name
		,	a.category_code
	FROM tbl_menu a
	JOIN tbl_category b ON (a.category_code = b.category_code);	
-- 일반적으로 join할때 나오는 테이블 순서대로 컬럼에 별칭을 단다. (a, b, c 순...)

-- join 알고리즘에 대한 notion 페이지는 면접을 위해 넣은 것. 

-- ------------------------
-- 1) inner join: on 또는 using 뒤에 오는 join의 조건을 만족하여 매칭되는 결과들만 join됨
SELECT 
			*
	FROM tbl_menu a
	JOIN tbl_category b ON (a.category_code = b.category_code)
  WHERE b.category_code = 7; 
  -- 조회 결과 없음(7번 카테고리(퓨전)는 존재하지만 join에는 존재하지 않는다.)
  
-- 2) left join: join 키워드를 기준으로 좌측에 위치한 테이블의 행이 모두 나오도록 join 한다.

-- 카테고리가 없는 메뉴를 만들기 위해
-- a. 메뉴 카테고리에 null이 들어갈 수 있게 not null 제약 조건 해제
SELECT * FROM tbl_menu WHERE menu_code = 1;
ALTER TABLE tbl_menu CHANGE category_code category_code INTEGER DEFAULT NULL;
-- ALTER TABLE tbl_menu MODIFY COLUMN category_code INTEGER NOT NULL; -- NOT NULL로 재설정

-- b. 1번 메뉴의 메뉴 카테고리가 null로 변경 되게 설정
UPDATE tbl_menu
   SET category_code = 6
 WHERE menu_code = 1;
 
-- c. 1번 메뉴의 메뉴 카테고리가 없는 상태에서 inner join vs left join 비교하기   
SELECT
       *
  FROM tbl_menu a
  JOIN tbl_category b ON (a.category_code = b.category_code);
  
SELECT
       *
  FROM tbl_menu a
  LEFT JOIN tbl_category b ON (a.category_code = b.category_code);

-- 3) right join: join 키워드를 기준으로 우측에 위치한 테이블의 행이 모두 나오도록 join 한다.

SELECT 
			*
	FROM tbl_menu a
	JOIN tbl_category b USING (category_code);
	
SELECT 
			*
	FROM tbl_menu a
	RIGHT JOIN tbl_category b USING (category_code);
	
-- 4) cross join: 
-- cross join은 의도했다기 보다는 on에 쓰는 join조건을 잘못 썼을 가능성이 높다.
-- 예) 모든 메뉴의 행과 모든 카테고리의 행을 매칭할 수 있는 경우의 수가 전부 나온다.

SELECT 
			*
	FROM 	tbl_menu a
	JOIN tbl_category b ON (1=1);

SELECT 
			*
	FROM 	tbl_menu a
	CROSS JOIN tbl_category b;
	
-- 5) self join
-- self join은 하나의 테이블에 상위 개념과 하위 개념이 모두 들어있을 때,
-- 자기 자신 테이블을 join하게 되는 경웅에 사용한다.
-- 예) 신입사원 vs 사수(선배사원), 하위 카테고리 vs 상위 카테고리, 댓글 vs 대댓글 등
SELECT 
			*
	FROM tbl_category;

SELECT 
			a.category_name 
	,		b.category_name 
	FROM tbl_category a
	JOIN tbl_category b ON (a.category_code = b.ref_category_code);
	

SELECT 
			*
	FROM tbl_category a
	JOIN tbl_category b ON (a.category_code = b.ref_category_code);

















-- -------------------------
-- 개인 연습
-- 메뉴의 가격이 10,000원 이하인 항목들을 카테고리까지 표시하여 조회
SELECT 
		  *
	FROM tbl_menu a
	JOIN tbl_category b ON a.category_code = b.category_code;
	WHERE a.menu_price <= 10000;
	

-- 메뉴의 가격이 10,000원 이하인 항목들을 카테고리까지 표시하여 조회
SELECT 
		  menu_name
	,	  menu_price
	,	  b.category_name
	FROM tbl_menu a JOIN tbl_category b ON a.category_code = b.category_code;
	WHERE a.menu_price <= 10000;
	
	
	
