-- ------------------------------
-- index (면접 준비 시, 거의 필수 질문)
-- 인덱스(Index)는 데이터 검색 속도를 향상시키는 데이터 구조로 데이터를 빠르게 조회할 수 있는 포인터를 제공한다.
-- 데이터베이스에서 데이터를 찾을 때 전체 테이블을 검색하는 대신 인덱스를 통해 검색을 하므로 속도가 더 빨라지게 된다.
-- 인덱스는 주로 WHERE절의 조건이나 JOIN 연산에 사용되는 컬럼에 생성한다.
-- 다만 인덱스도 데이터 저장 공간을 차지하고 데이터가 변경될 때마다 인덱스 역시 갱신해야 하기 때문에 어떤 컬럼에 인덱스를 생성할지는 신중히 결정해야 한다.


CREATE TABLE phone (
    phone_code INT PRIMARY KEY,
    phone_name VARCHAR(100),
    phone_price DECIMAL(10, 2)
);

INSERT 
  INTO phone (phone_code , phone_name , phone_price )
VALUES 
(1, 'galaxyS23', 1200000),
(2, 'iPhone14pro', 1433000),
(3, 'galaxyZfold3', 1730000);

SELECT * FROM phone;


-- 단순 조회
SELECT * FROM phone WHERE phone_name = 'galaxyS23';

-- 조회의 실행계획 확인
EXPLAIN SELECT * FROM phone WHERE phone_name = 'galaxyS23';

-- where절에 활용한 컬럼에 index를 추가해 보자.
CREATE INDEX idx_name ON phone (phone_name);

SHOW INDEX FROM phone;

-- 인덱스 추가 후, 다시 해당 컬럼을 조건으로 해서 조회
EXPLAIN SELECT * FROM phone WHERE phone_name = 'iPhone14pro';

-- index 수정 가능.
ALTER TABLE phone DROP INDEX idx_name;
ALTER TABLE phone ADD INDEX idx_name(phone_name);

-- index는 주기적으로 다시 달아주어야 된다.(= 갱신)
OPTIMIZE TABLE phone;

-- index 삭제 후, 확인
DROP INDEX idx_name ON phone;
SHOW INDEX FROM phone;




