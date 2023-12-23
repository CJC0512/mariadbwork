SELECT 
		menu_code
	,	menu_name
	,	category_code
	FROM tbl_menu;
	
DESC tbl_category;	

SELECT 
		category_code
	,	category_name
	,	ref_category_code
	FROM tbl_category;
	
SELECT 
		menu_name
	,	category_name
	FROM tbl_menu a
	JOIN tbl_category b ON (a.category_code = b.category_code);
	
SELECT 10 + 7 '합';
SELECT 20 * 3 곱;
SELECT 20 - 13 AS '차';
SELECT '합' + '곱';

SELECT NOW() AS '현재 시간';

SELECT CONCAT('유','관순');