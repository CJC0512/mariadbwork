-- ---------------------------
-- DLL(Data Definition Language)
-- 테이블을 건드리는 것. 객체를 만들거나 수정하거나 삭제하는것.
-- 데이터베이스의 스키마(제약 조건, 구조 등의 개념)를 정의하거나 수정하는 데 사용되는 SQL의 한 부분
-- 스키마(schema): 테이블의 구조(컬럼명, 자료형, 자료형 크기, 테이블 명 등) 및 
--	제약조건 전반을 아울러 지칭하는 말.

-- create (table)
-- if not exists 를 넣어서 테이블이 존재했을 때, 발생하는 에러를 피할 수 있다.


CREATE TABLE if NOT EXISTS tb1(
	pk INT PRIMARY KEY 
,	fk INT
,	col1 VARCHAR(255)		-- varchar: 가변자료 char 
,	CHECK(col1 IN ('Y', 'N')) -- [테이블 레벨에서 제약조건 추가]
) ENGINE=INNODB;

-- primary key 자체가 unique와 not null 특성을 가지고 있다. 
-- 차후 수정도 안 됨.

DESC tb1;

INSERT 
  INTO tb1
VALUES
(
  1, 2, 'Y'
);


SELECT * FROM tb1;

-- --------------------
-- auto_increment 


DROP TABLE tb2;	-- 테이블을 잘못 만들었을 경우.

CREATE TABLE if NOT EXISTS tb2(
	pk INT PRIMARY KEY auto_increment-- 컬럼 레벨에 제약조건 추가 auto_increment
,	fk INT
,	col1 VARCHAR(255)		-- varchar: 가변자료 char 
,	CHECK(col1 IN ('Y', 'N')) -- [테이블 레벨에서 제약조건 추가]
) ENGINE=INNODB;

DESC tb2;

INSERT 
  INTO tb2
VALUES
(
  null, 2, 'Y'
);

SELECT * FROM tb2;


-- -------------------
-- Alter
-- 열 부분 수정
-- alter table 테이블명 add 컬럼명 컬럼정의

ALTER TABLE tb2
ADD col2 INT NOT NULL;

DESC tb2;

ALTER TABLE tb2
DROP COLUMN col2; 


-- 컬럼 이름 및 컬럼 정의 변경
ALTER TABLE tb2
CHANGE COLUMN fk change_fk INT NOT NULL;

SELECT * FROM tb2;

-- 제약조건 제거		-- auto_increment로 인해 제거가 안 됨.
ALTER TABLE tb2 DROP PRIMARY KEY;

-- auto_increment 제거
ALTER TABLE tb2 MODIFY pk INT;

-- 다시 primary key 제거
ALTER TABLE tb2 DROP PRIMARY KEY;

-- Drop
DROP TABLE if EXISTS tb3; 	-- 이런식.

-- Truncate 
-- delete 보다 빠르고 데이터블보다 빠름
-- 완벽한 초기화

CREATE TABLE if NOT EXISTS tb6 (
  pk INT AUTO_INCREMENT PRIMARY KEY
, fk INT
, col1 VARCHAR(255)
, CHECK(col1 IN ('Y','N'))
) ENGINE=INNODB;

INSERT INTO tb6 VALUES (NULL, 10, 'Y');
INSERT INTO tb6 VALUES (NULL, 20, 'Y');
INSERT INTO tb6 VALUES (NULL, 30, 'Y');
INSERT INTO tb6 VALUES (NULL, 40, 'Y');
	
SELECT * FROM tb6;

-- TRUNCATE TABLE tb6;
TRUNCATE tb6;	-- table 생략가능








