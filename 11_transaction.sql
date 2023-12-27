-- -------------------------
-- Transaction
-- 데이터베이스에서 한 번에 수행되는 작업의 단위

-- autocommit 비활성화	-- transaction 하기위한 사전 작업
SET autocommit = 0;
-- 또는
SET autocommit = OFF;

-- commit 이후에는 Rollback을 해도 Rollback이 적용되지 않는다.
START TRANSACTION;	-- transaction 시작 위치로 지정


INSERT 
  INTO tbl_menu 
VALUES 
(
  NULL, '바나나해장국', 8500
, 4, 'Y'
);
UPDATE tbl_menu 
   SET menu_name = '수정된 메뉴1' 
 WHERE menu_code = 5;
UPDATE tbl_menu 
   SET menu_name = '수정된 메뉴2' 
 WHERE menu_code = 6; 

SELECT 			-- 가상의 상태도 조회. 즉, 이때 조회된 데이터는 실제 DB에 적용된 값이 아니다.
		  * 
	FROM tbl_menu;
	
-- DELETE FROM tbl_menu WHERE menu_code = 7;

-- COMMIT;
ROLLBACK;	-- transaction 시작 시점으로 database 변경

SELECT * FROM tbl_menu;	-- rollback 또는 commit 이후 select 한 것이 실제 DB에 적용된 값이다.

