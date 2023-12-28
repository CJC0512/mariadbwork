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
SELECT  LPAD('왼쪽', 5, '#'), RPAD('오른쪽', 5, '*'), LPAD('왼쪽', 10, '핫초코')
		, LPAD('왼쪽', 1, '크치킨'), RPAD('오른쪽',1,'크치킨');

-- LTRIM(문자열), RTRIM(문자열)   공백제거
SELECT  LTRIM('      김  왼쪽'), RTRIM('오른쪽        ')
		, RTRIM(LTRIM('      메롱    ')), TRIM('   메타 몽   ')
		, RTRIM(LTRIM('      메롱 츄   '));
		
SELECT  TRIM('       mariaDB        ')
		, TRIM(BOTH '@' FROM '@@@@@@@@@MariaDB@@@@@@@@')
		, TRIM(LEADING '@' FROM '@@@@@@@@@MariaDB@@@@@@@@')		-- leading = 왼쪽  (왼쪽으로 가는 기차를 생각)
		, TRIM(TRAILING '@' FROM '@@@@@@@@@MariaDB@@@@@@@@');		-- trailling = 오른쪽	
		
-- -----------------------------
-- -----------------------------
-- format(숫자, 소수점 자릿수)
SELECT FORMAT(12312314566, 3);

-- bin(숫자), oct(숫자), hex(숫자)	각각 2진수 8진수 16진수
SELECT BIN(65), OCT(65), HEX(65);

-- repeat(문자열, 횟수)
SELECT repeat('아주 좋아 ~ ', 5);

-- replace(문자열, 찾을 문자열, 바꿀 문자열)
SELECT REPLACE('마리아DB', '마리아', 'Maria');
SELECT REPLACE('내 롤 티어 플레티넘', '플레티넘', '에메랄드');

-- reverse(문자열)
SELECT REVERSE('우영우는 거꾸로해도 우영우');

-- space(길이)
SELECT CONCAT('제 디지몬은', SPACE(3), '이고, 속성은', SPACE(6), '입니다.');

-- substring(문자열, 시작위치, 길이) -- 여기서 index번호는 1부터 시작.
SELECT 
		  SUBSTRING('열심히 db공부를 해 봅시다!', 5, 4)
		, SUBSTRING('열심히 db공부를 해 봅시다!', 5, 12)
		, SUBSTRING('열심히 db공부를 해 봅시다!', 5)
		, SUBSTRING('열심히 db공부를 해 봅시다!', -6);

-- substring_index(문자열, 구분자, 횟수)
SELECT
		  SUBSTRING_INDEX('010-123-1234','-',2)
		, SUBSTRING_INDEX('010-123-1234','-',-1);

-- 2. 숫자 관련 함수
-- abs(숫자)
SELECT ABS(-1234);

-- ceiling(숫자), floor(숫자), round(숫자)	각각 올림, 내림, 반올림
SELECT  CEILING(1234.56), FLOOR(1234.56), ROUND(1234.44)
		, ROUND(1234.5), ROUND(1234.567, 1), ROUND(1234.567, 2)
		, ROUND(1234.567, -2);

-- conv(숫자, 원래 진수, 변환할 진수)
SELECT CONV(86, 10, 5), CONV('A', 16, 10), CONV('A', 16, 2);

-- mod(나눌 숫자, 나누는 숫자)
SELECT MOD(10,3), MOD(10,5), 10%3;

-- pow(n승할 수, n), SQRT(숫자)		각각 제곱, 루트씌우기
SELECT POW(3,4), SQRT(81);

-- rand()	0.0000000000.. ~ 0.999999999.. 난수 생성
-- rand() * 생성할 난수 갯수 + 난수의 초기값
SELECT fllor(RAND() * 4 + 5), FLOOR(RAND() * 4) + 5;

-- sign(숫자) 부호 확인
SELECT SIGN(10.1), SIGN(0), SIGN(-1.1);

-- truncate(숫자, 정수)	소수점 (아래/위) 자리 표기 
SELECT TRUNCATE(12345.12345, 2), TRUNCATE(12345.12345, -2);

-- 3. 날짜 및 시간 관련 함수
-- adddate(날짜, 차이), subdate(날짜, 차이)
SELECT 
		  ADDDATE('2020-02-01', INTERVAL 28 DAY)	-- 윤년을 고려한 날짜 더하기
		, ADDDATE('2020-02-01', 28)
		, ADDDATE('2020-02-01', INTERVAL 28 MONTH);

SELECT 
		  SUBDATE('2020-02-01', INTERVAL 1 DAY)	-- 윤년을 고려한 날짜 빼기
		, SUBDATE('2020-02-01', 1)
		, SUBDATE('2020-02-01', INTERVAL 1 MONTH);

-- addtime(날짜/시간, 시간), subtime(날짜/시간, 시간)
SELECT ADDTIME('2023-12-28 10:27:00', '1:0:10');
SELECT SUBTIME('2023-12-28 10:27:00', '1:0:10');

-- curdate(), curtime(), now(), sysdate() 현재 시간(날짜) 조회
SELECT CURDATE(), CURTIME(), NOW(), SYSDATE();

SELECT CURTIME(), CURRENT_TIME(), CURRENT_TIME;

SELECT @@GLOBAL.time_zone; -- 현재 타임존 기준을 확인하는 조회문

-- year(날짜), month(날짜), day(날짜)
SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAY(CURDATE()), DAY(CAST('2023-12-28' AS DATE));

SELECT HOUR(CURTIME()), MINUTE(curtime()), SECOND(CURTIME());

SELECT DATE(NOW()), TIME(NOW());

-- datediff(날짜1, 날짜2) timediff(날짜1 또는 시간1, 날짜 2 또는 시간 2)
SELECT DATEDIFF('2024-06-14', '2023-12-28'), TIMEDIFF('18:00:00', CURTIME());

-- dayofweek(날짜), monthname(날짜), dayofyear(날짜)
SELECT DAYOFWEEK(CURDATE()), MONTHNAME(CURDATE()0), DAYOFYEAR(CURDATE());

-- last_day(날짜)
SELECT LAST_DAY('20230201') ;

-- makedate(연도, 지난 날)
SELECT MAKEDATE(2023, 35);

-- maketime(시, 분, 초)
SELECT MAKETIME(17, 50, 01);

-- quarter(날짜) 	분기 출력
SELECT QUARTER('2023-12-28');

-- time_to_sec(시간)
SELECT  TIME_TO_SEC(CURTIME())		-- 오늘 하루 중, 흐른 시간
		, TIME_TO_SEC('0:0:0');