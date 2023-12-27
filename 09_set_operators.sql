-- ----------------------------
-- set_operators
-- join이 열 추가라면 set 연산자는 행을 추가하는 개념

-- Union(합집합)
-- A U B
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE category_code = 10
 UNION -- 합집합
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE menu_price < 9000;



-- Union all(덧셈)
-- A + B
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE category_code = 10
 UNION ALL -- 덧셈
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE menu_price < 9000;
 
-- Intersect(교집함)
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE category_code = 10
 intersect -- 교집합. 원래 지원하지 않음. Join 이나 in을 활용해서 구현해야함.
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE menu_price < 9000;

-- inner join 활용 
SELECT 
		 a.menu_code
	  , a.menu_name
	  , a.menu_price
	  , a.category_code
	  , a.orderable_status
  FROM tbl_menu a
 INNER JOIN (SELECT 	 menu_code
						  , menu_name
						  , menu_price
						  , category_code
						  , orderable_status
					  FROM tbl_menu
					 WHERE menu_price < 9000) b ON (a.menu_code = b.menu_code)
 WHERE a.category_code = 10 ;
 
-- in 활용
SELECT
       a.menu_code
     , a.menu_name
     , a.menu_price
     , a.category_code
     , a.orderable_status
  FROM tbl_menu a
 WHERE category_code = 10 
   AND menu_code IN (SELECT menu_code
                       FROM tbl_menu
                      WHERE menu_price < 9000);
	 
	 
-- Minus(차집합)
-- MySQL은 Minus 기능을 지원하지 않기에, left join을 통해서 차집합을 구현해야한다.

SELECT
       a.menu_code
     , a.menu_name
     , a.menu_price
     , a.category_code
     , a.orderable_status
--      , b.*		-- b 요소를 전부 넣었을 때 null인 항목을 확인할 수 있다.
  FROM tbl_menu a
  LEFT JOIN (SELECT menu_code
                  , menu_name
                  , menu_price
                  , category_code
                  , orderable_status
               FROM tbl_menu
              WHERE menu_price < 9000) b ON (a.menu_code = b.menu_code)
 WHERE a.category_code = 10
   AND b.menu_code IS NULL;
