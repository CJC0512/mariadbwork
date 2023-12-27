-- -------------------------------
-- build in function
-- 1. 문자열 관련 함수

-- ASCII(아스키코드), char(숫자)
SELECT ASCII('a'), CHAR('97');

-- bit_length(문자열), char_length(문자열), length(문자열)
-- 영어, 숫자, 특수기호 제외, 한 문자당 3바이트 할당
SELECT 
		  BIT_LENGTH('한글')
		, CHAR_LENGTH('한글')
		, LENGTH('한글');

-- concat(문자열1, 문자열2, ...), concat_ws(구분자, 문자열1, 문자열2)
SELECT 
		  CONCAT('안녕','하세요')
		, CONCAT_WS('/','2023','12','27');
		
SELECT 
		  concat(cast(menu_price AS CHAR), '원')
	FROM tbl_menu;

-- concat 활용
SELECT concat(menu_name, '의 가격은 ', menu_price, '원 입니다.') FROM tbl_menu;

	
-- ELT(위치, 문자열1, 무낮열2, ...), FIELD(찾을 문자열, 문자열1, 문자열2, ...)
-- FIND_IN_SET(찾을 문자열, 문자열 리스트), INSTR(기준 문자열, 부분 문자열).
-- LOCATE(부분 문자열, 기준 문자열)
SELECT
		  ELT(1, '한식', '중식', '일식')
		, FIELD('일식','한식','중식','일식')
		, FIND_IN_SET('중식','한식,중식,일식')  -- ,를 기준으로 parsing. 리스트를 만듦.
		, INSTR('한식중식일식','일식')
		, LOCATE('중식','한식중식일식'); -- instr과 locate는 서로 인자만 반대	
		
-- insert(기준 문자열, 지울 위치, 지울 길이, 삽입할 문자열)
SELECT INSERT('나와라 꼬북이!', 5, 1, '피카츄');

-- left(문자열, 길이), right(문자열, 길이)
SELECT LEFT('Hello World!', 5), RIGHT('Nice shot!', 5);

-- upper(문자열), lower(문자열)
SELECT LOWER('Hello World!'), UPPER('Hello World!');

-- LPAD(문자열, 출력할 길이, 채울 문자열), RPAD(문자열, 길이, 채울 문자열)
SELECT LPAD('왼쪽', 5, '#'), RPAD('오른쪽', 5, '*'), LPAD('왼쪽', 10, '핫초코'), LPAD('왼쪽', 1, '크치킨');

-- LTRIM(문자열), RTRIM(문자열)   공백제거
SELECT LTRIM('      김  왼쪽'), RTRIM('오른쪽        ')
		,RTRIM(LTRIM('      메롱    ')), TRIM('   메타 몽   ')
		,RTRIM(LTRIM('      메롱 츄   '));
		
SELECT  TRIM('       mariaDB        ')
		, TRIM(BOTH '@' FROM '@@@@@@@@@MariaDB@@@@@@@@')
		, TRIM(LEADING '@' FROM '@@@@@@@@@MariaDB@@@@@@@@')		-- leading = 왼쪽  (왼쪽으로 가는 기차를 생각)
		, TRIM(TRAILING '@' FROM '@@@@@@@@@MariaDB@@@@@@@@');		-- trailling = 오른쪽	
		

-- 2. 숫자 관련 함수



-- 3. 날짜 및 시간 관련 함수


