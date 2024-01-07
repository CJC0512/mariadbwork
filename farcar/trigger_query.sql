-- User 테이블에 대한 Trigger 정의
DELIMITER //
CREATE TRIGGER AfterReportUpdate
BEFORE UPDATE ON User
FOR EACH ROW
BEGIN
  -- 누적신고횟수가 5의 배수일 때 제재 적용
  IF NEW.Report_issue_stack % 5 = 0 AND NEW.Report_issue_stack < 30 THEN
    SET NEW.User_blacklist = 1;
    SET NEW.Restriction_date = NOW();
    SET NEW.Restriction_end_date = DATE_ADD(NOW(), INTERVAL NEW.Report_issue_stack DAY);
  END IF;

  -- 누적신고횟수가 30이 넘어가면 회원의 회원탈퇴 여부가 1(탈퇴)로 업데이트
  IF NEW.Report_issue_stack >= 30 THEN
 		SET NEW.User_withdraw_check = 1;
 		SET NEW.User_withdraw_date = NOW();
  END IF;
END;
//
DELIMITER ;




SELECT * FROM user;
INSERT INTO User (
	User_ID, User_name, User_nickname, User_password, User_email, User_phoneNum,
	User_address, User_birth, User_sign_up_date, User_coupon, Dealer_company,
	Dealer_region, Dealer_grade, User_type, User_blacklist, Restriction_date, Restriction_end_date,
	Login_fail_stack, Report_issue_stack, Login_restriction_check, User_withdraw_check,
	User_withdraw_date 
)
VALUES 
(
 99, 
 '홍길동',
 '회원닉네임이영ㅇㅇ',
 'qlalfqjsgh1234',
 'hongmail@daum.net',
 '010-2222-5555',
 '부산',
 '1993-1-3 00:00:00',
  NOW(),
  NULL,	-- 보유쿠폰
  NULL,	
  NULL,  
  NULL,	-- 딜러등급
  0,	-- 회원유형 1=판매자 0=구매자
  NULL,	-- 블랙 여부
  NULL,	-- 제재 시작일
  NULL,	-- 제재 종료일
  NULL,	-- 로그인 실패 횟수
  4,	-- 누적 신고 횟수
  NULL,	-- 로그인 제한 여부
  0,	-- 탈퇴여부
  NULL -- 탈퇴날짜
),
(
 100, 
 '홍구구',
 '회원닉네임이영ㅇㅇ',
 'qlalfqjsgh1234',
 'hongmail@daum.net',
 '010-2222-5555',
 '대구',
 '1996-1-3 00:00:00',
  NOW(),
  NULL,	-- 보유쿠폰
  NULL,	
  NULL,  
  NULL,	-- 딜러등급
  0,	-- 회원유형 1=판매자 0=구매자
  1,	-- 블랙 여부
  NULL,	-- 제재 시작일
  NULL,	-- 제재 종료일
  NULL,	-- 로그인 실패 횟수
  28,	-- 누적 신고 횟수
  NULL,	-- 로그인 제한 여부
  0,	-- 탈퇴여부
  NULL -- 탈퇴날짜
);
SELECT * FROM user;
UPDATE user SET report_issue_stack = report_issue_stack + 1 WHERE User_ID IN (99, 100);
SELECT * FROM USER;
UPDATE user SET report_issue_stack = report_issue_stack + 5 WHERE User_ID IN (99, 100);
SELECT * FROM USER;


DELETE FROM USER WHERE user_id IN (99,100);