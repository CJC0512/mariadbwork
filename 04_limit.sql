-- ----------------------
-- limit
-- select문의 결과집합에서 반환할 행의 수를 제한하는데 사용된다.
-- top-n분석이나 paging 처리를 할 때, 주로 사용된다.

-- limit n, n번째 행까지 조회
SELECT 
		  *
	FROM tbl_menu
  LIMIT 5;

-- limit 시작 인덱스, 시작 인덱스부터 조회할 행의 갯수 
SELECT 
		  *
	FROM tbl_menu
  LIMIT 0, 5; 

-- 예) 6행부터 5개의 메뉴 행 조회
SELECT 
		  *
	FROM tbl_menu
  LIMIT 5, 5; 

-- limit은 select절이 끝나고 난 뒤에 적용된다. 
SELECT 
			menu_code
	,	 	menu_name
	,	 	menu_price
	FROM	tbl_menu
ORDER BY menu_price DESC, menu_name ASC
	LIMIT 5;

