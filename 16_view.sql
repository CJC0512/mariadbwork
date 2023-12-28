-- ------------------------------
-- view

SELECT 
		  menu_name	
		, menu_price	
  FROM tbl_menu;
  
CREATE VIEW v_menu
AS
SELECT
		  menu_name	
		, menu_price
	FROM tbl_menu;
	
SELECT * FROM v_menu;

-- view는 원본테이블을 참조해서 보여주는 용도이고 실제 보여지는건 원본 테이블의 데이터이다.

-- 원본인 tbl_menu의 11번 메뉴 가격을 10원으로 수정해보자.
UPDATE tbl_menu
   SET menu_price = 10
 WHERE menu_code = 11;
 
-- v_menu(뷰)로 확인해 보자.
SELECT * FROM v_menu;


-- or replace
-- view는 table과 달리 create or replace 기능으로 view 자체를 수정도 가능하다.
CREATE or replace VIEW v_menu
AS
SELECT
		  menu_name		'메뉴이름'
		, menu_price	'메뉴가격'
	FROM tbl_menu;
	
SELECT '메뉴이름' FROM v_menu;   -- 원본 데이블 명의 이름을 숨김 및 세부 항목들 은닉화.
SELECT 메뉴이름 FROM v_menu;   -- 뷰 생성 시, 별칭으로 생성했다면 뷰를 통한 조회는 별칭으로만 가능하다.
SELECT '메뉴' FROM v_menu;
SELECT * FROM v_menu;
-- ------------------
-- view를 통한 DML (절대 절대 절대 비추ㅜㅜㅜㅜㅜ)
SELECT * FROM tbl_menu;

-- VIEW 생성
CREATE VIEW hansik AS
SELECT 
       menu_code 
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu 
 WHERE category_code = 4;

-- 생성된 VIEW 조회
SELECT * FROM hansik;

-- INSERT INTO hansik VALUES (null, '식혜맛국밥', 5500, 4, 'Y');    -- 에러 발생
INSERT 
  INTO hansik
VALUES (99, '수정과맛국밥', 5500, 4, 'Y');   
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

-- view를 통해 원본도 update 가능 (절대 절대 절대 비추ㅜㅜㅜㅜㅜㅜㅜㅜ)
UPDATE hansik
   SET menu_name = '버터맛국밥', menu_price = 5700 
 WHERE menu_code = 99;
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

-- view를 통해 원본도 delete 가능 (절대 절대 절대 비추ㅜㅜㅜㅜㅜㅜㅜㅜㅜ)
DELETE FROM hansik WHERE menu_code = 99;
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

-- view로 DML 명령어로 조작이 불가능한 경우  (시험X. 감만 잡을 것)
-- 1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
-- 2. 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 테이블 컬럼이 NOT NULL 제약조건이 지정된 경우
-- 3. 산술 표현식이 정의된 경우
-- 4. JOIN을 이용해 여러 테이블을 연결한 경우
-- 5. DISTINCT를 포함한 경우
-- 6. 그룹함수나 GROUP BY 절을 포함한 경우

-- view 삭제  (계정, 테이블, 뷰는 모두 객체. drop으로 제거)
DROP VIEW hansik;


