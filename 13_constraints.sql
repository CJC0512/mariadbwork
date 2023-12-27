-- -------------------------
-- constraints 
-- 1. not null 제약조건 -- 컬럼레벨에 넣을 수 없음
DROP TABLE IF EXISTS user_notnull;
CREATE TABLE IF NOT EXISTS user_notnull (
    user_no INT NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255)
) ENGINE=INNODB;

INSERT 
  INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_notnull;

-- user_pwd가 null이여서 오류 발생
INSERT
  INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(3, 'user03', null, '이순신', '남', '010-222-2222', 'lee222@gmail.com');


-- 2. unique
-- 중복값을 허용하지 않는 제약조건
DROP TABLE IF EXISTS user_unique;
CREATE TABLE IF NOT EXISTS user_unique (
    user_no INT NOT NULL UNIQUE,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    UNIQUE (phone)
) ENGINE=INNODB;

INSERT
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_unique;

-- phone 번호 중복 에러 발생
INSERT 
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');

-- 3. primary key
-- 제일 우선시해서 걸어야하는 제약조건.
-- 모든 테이블은 primary key를 가져야하고, 하나만 가져야함.
-- 목적은 하나의 행만을 선택할 수 있도록 하는 것. (식별자 역할 identifier)
-- 한 개 컬럼에 설정할 수도 있고, 여러 개의 컬럼을 묶어서 설정할 수도 있음(=복합키)(테이블 레벨 설정만 가능함) 
-- 예)	primary_key(menu_code, order_code)

DROP TABLE IF EXISTS user_primarykey;
CREATE TABLE IF NOT EXISTS user_primarykey (
--     user_no INT PRIMARY KEY,
    user_no INT,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    PRIMARY KEY (user_no)
) ENGINE=INNODB;

INSERT 
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_primarykey;

-- user_no null 에러 발생
INSERT 
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(null, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');

-- user_no에 중복값 적용(에러 발생)
INSERT 
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(2, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');



-- 4. foreign key: 참조된 다른 테이블에서 제공하는 값만 사용할 수 있음.		--  놓침. github보고 수정!
-- 상대방 테이블의 pk가 본인 테이블에 넘어오면 그것이 foreign key가 된다.
-- restrict, cascade, set null, no action 등 delete시 동작을 설정할 수 있다.
-- https://mariadb.com/kb/en/foreign-keys/ 참고

-- 4-1. 회원등급 부모 테이블 먼저 생성
DROP TABLE IF EXISTS user_grade;
CREATE TABLE IF NOT EXISTS user_grade (
    grade_code INT NOT NULL UNIQUE,
    grade_name VARCHAR(255) NOT NULL
) ENGINE=INNODB;

INSERT 
  INTO user_grade
VALUES 
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');

SELECT * FROM user_grade;

-- 4-2.회원 자식 테이블 이후에 생성
DROP TABLE IF EXISTS user_foreignkey1;
CREATE TABLE IF NOT EXISTS user_foreignkey1 (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT ,
    FOREIGN KEY (grade_code) 
		REFERENCES user_grade (grade_code)
) ENGINE=INNODB;

INSERT 
  INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey1;

-- 부모 테이블에 없는 등급으로 insert
INSERT 
  INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com', 50);

-- 자식테이블에서 foreign key 제약조건 컬럼 null값으로 insert
INSERT 
  INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com', NULL);


-- -------------------
-- 5. 삭제룰을 적용한 foreign key(=외래키) 제약조건

DROP TABLE IF EXISTS user_foreignkey2;
CREATE TABLE IF NOT EXISTS user_foreignkey2 (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT ,
    FOREIGN KEY (grade_code) 
		REFERENCES user_grade (grade_code)
        ON UPDATE SET NULL		-- 중요
        ON DELETE SET NULL
) ENGINE=INNODB;

INSERT 
  INTO user_foreignkey2
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey2;

-- 부모 테이블에서 우수 회원 등급 삭제
SELECT * FROM user_grade;
DELETE FROM user_grade WHERE grade_code = 20;	
-- user_foreignkey1 테이블은 삭제룰을 적용하지 않고 20을 참조한 데이터가 있다.

DELETE FROM user_foreignkey1 WHERE 1=1;	-- user_foreignkey1 테이블의 참조하는 데이터 삭제

SELECT * FROM user_foreignkey2;
DELETE FROM user_grade WHERE grade_code = 20;	

-- 부모 테이블에 새로운 등급 추가
INSERT 
  INTO user_grade
VALUES (40, '에메랄드 회원');

-- null값으로 변화된 자식 테이블의 행들을 새로추가한 회원 등급으로 업데이트
UPDATE user_foreignkey2
   SET grade_code = 40
 WHERE grade_code IS NULL;

-- 확인
SELECT * FROM user_foreignkey2;

-- ----------------------------------------
-- 6. check 제약조건(조건식을 활용한 구체적인 제약조건)
-- 테이블 레벨, 컬럼 레벨 모두 위치가능
-- check(조건식)

DROP TABLE IF EXISTS user_check;
CREATE TABLE IF NOT EXISTS user_check (
    user_no INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3) CHECK(gender IN ('남','여')),
    age INT CHECK (age >= 19)
) ENGINE=INNODB;

INSERT 
  INTO user_check
VALUES 
(null, '홍길동', '남', 25),
(null, '이순신', '남', 33);

SELECT * FROM user_check;

-- 성별에 잘못된 값 입력해보기
INSERT 
  INTO user_check
VALUES (NULL, '아메바', '중성', 19);

-- 나이에 잘못된 값 입력해보기
INSERT
  INTO user_check
VALUES (NULL, '유관순', '여', 16);


-- ---------------------------------------
-- 7. Default
-- 컬럼 타입이 date일 시 current_date만 가능

-- 나라에 대한 테이블
DROP TABLE IF EXISTS tbl_country;
CREATE TABLE IF NOT EXISTS tbl_country (
    country_code INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(255) DEFAULT '한국',
    population VARCHAR(255) DEFAULT '0명',
    add_day DATE DEFAULT (current_date),
    add_time DATETIME DEFAULT (CURRENT_TIME)		-- DEFAULT(NOW) 도 가능
) ENGINE=INNODB;

SELECT * FROM tbl_country;

-- default로 insert 또는 update를 하면 default로 초기 세팅된값으로 적용된다.
INSERT 
  INTO tbl_country
VALUES (null, default, default, default, default);

-- insert 시 default 설정된 컬럼을 무시하고 insert하면 null이 아닌 default로 초기 세팅된 값이 들어간다.
INSERT
  INTO tbl_country
(country_code)
VALUES
(NULL);

SELECT * FROM tbl_country;


