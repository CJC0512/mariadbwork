-- 모든 데이터베이스 생성, 권한부여는 root에서 처리해야된다!
CREATE USER 'practice'@'%' IDENTIFIED BY 'practice';

CREATE DATABASE employeedb;

GRANT ALL PRIVILEGES ON employeedb.* TO 'practice'@'%';

