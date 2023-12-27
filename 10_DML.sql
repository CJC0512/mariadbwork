-- --------------------------
-- DML(Data Manipulation Language)
-- 데이터 조작언어, 테이블에 값을 삽입하거나 수정하거나 삭제하는 SQL의 한 부분이다.
-- 1. INSERT
-- 기존에 없는 행을 새로 추가하는 구문
-- 각 항목에 대해 명시하지 않을 경우, 정확하게 컬럼의 숫자와 개수를 동일하게 해야 넣어진다.
-- 명시할 경우 특정 열의 값을 빈칸으로 할 수 있다. 

DESC tbl_menu;
INSERT 
  INTO tbl_menu
(
	menu_code
,	menu_name
,	menu_price
,	category_code
,	orderable_status
)
VALUES
(
	NULL, '바나나해장국'		-- 한글은 보통 한글자에 3byte다. 영어, 특수기호는 한글자에 1byte.
,	8500, 4
,	'Y'
);

SELECT * FROM tbl_menu ORDER BY 1 DESC;  -- 성공적으로 들어갔는지 확인.


-- 2. UPDATE
-- 기존에 있는 행의 값을 수정하는 구문

UPDATE tbl_menu
	SET menu_name = '딸기해장국'
 WHERE menu_code = 22;

-- 3. DELETE
-- 기존에 있는 행을 제거하는 구문

DELETE 
  FROM tbl_menu
 WHERE menu_code = 23;

DELETE 
  FROM tbl_menu
ORDER BY menu_price LIMIT 2;


-- 4. REPLACE
-- insert시 primary key 또는 unique key가 충돌이 발생할 수 있다면
-- replace를 통해 중복 된 데이터를 덮어 쓸 수 있다.

-- primary key 중복 현상 예시 코드
INSERT 
  INTO tbl_menu
(
	menu_code,	menu_name,	menu_price  
,	category_code, orderable_status
)
VALUES 
(
	17, '아샷추매운탕', 9000
,	4, 'N'
);  
  

REPLACE 
   into tbl_menu 
(
	menu_code,	menu_name,	menu_price  
,	category_code, orderable_status
)
VALUES 
(
	17, '아샷추매운탕', 9000
,	4, 'N'
);  
  
 
SELECT * FROM tbl_menu WHERE menu_code = 17;  
  



