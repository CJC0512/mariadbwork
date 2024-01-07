CREATE TABLE model (
	Model_ID	VARCHAR(255)	PRIMARY KEY COMMENT '차종코드',
	Model_name	VARCHAR(255)	NOT NULL COMMENT '차종명',
	Model_description	TEXT NOT NULL COMMENT '차종 설명'
)COMMENT = '차종';

CREATE TABLE Car (
	Car_ID	INT	PRIMARY KEY AUTO_INCREMENT COMMENT '자동차 ID',
	Car_field	VARCHAR(255)	NOT NULL COMMENT '제조사',
	Car_model	VARCHAR(255)	NOT NULL COMMENT '모델',
	Car_year	INT	NOT NULL COMMENT '연식',
	Car_mileage	INT	NOT NULL COMMENT '주행거리',
	Car_condition	VARCHAR(255)	NOT NULL COMMENT '컨디션',
	Car_transmission	VARCHAR(255)	NOT NULL COMMENT '변속기',
	Car_oiltype	VARCHAR(255)	NOT NULL COMMENT '연료 종류',
	Car_engine	VARCHAR(255)	NOT NULL COMMENT '엔진 크기',
	Car_fuel_efficiency	INT	NOT NULL COMMENT '연비',
	Accident_check	TINYINT(1)	NOT NULL	DEFAULT 0 COMMENT '사고 여부',
	Inundation_check	TINYINT(1)	NOT NULL	DEFAULT 0 COMMENT '침수 여부',
	Selling_price	INT	NOT NULL COMMENT '매물가격',
	Picture_URL	VARCHAR(255)	NOT NULL DEFAULT '-' COMMENT '사진 경로',
	Picture_origin	VARCHAR(255)	NOT NULL DEFAULT '-' COMMENT '원본사진 이름',
	Picture_rename	VARCHAR(255)	NOT NULL DEFAULT '-' COMMENT '사진 이름',
	Model_ID	VARCHAR(255)	NOT NULL COMMENT '차종코드',
  Insepction_record_URL  VARCHAR(255) NOT NULL COMMENT '성능점검기록부',
  FOREIGN KEY(Model_ID) REFERENCES model (Model_ID)
)COMMENT = '자동차';


CREATE TABLE Ownership_history (
	Ownership_ID	INT	PRIMARY KEY AUTO_INCREMENT COMMENT '소유이력ID',
	Previous_Owner	VARCHAR(255)	NULL	DEFAULT '-' COMMENT '이전소유자',
	Current_Owner	VARCHAR(255)	NOT NULL COMMENT '현재소유자',
	Ownership_start	DATETIME	NOT NULL COMMENT '소유시작일',
	Ownership_end	DATETIME	NOT NULL COMMENT '소유종료일',
	Reason_transfer	TEXT	NOT NULL COMMENT '소유이전된이유',
	Descript_transfer	TEXT	NOT NULL COMMENT '소유이전된상세설명',
	Car_ID	INT	NOT NULL COMMENT '자동차 ID',
  FOREIGN KEY(Car_ID) references Car(Car_ID)
)COMMENT = '소유이력';

CREATE TABLE Accident (
	Accident_code VARCHAR(255) NOT NULL COMMENT '사고  코드',
	Accident_type VARCHAR(255) NOT NULL COMMENT '사고 유형',
	Accident_description TEXT NOT NULL COMMENT '사고 유형 설명',
	CONSTRAINT PK_ACCIDENT PRIMARY KEY (Accident_code)
)COMMENT = '사고';

CREATE TABLE Accident_History (
	Accident_ID INT AUTO_INCREMENT COMMENT '차동자 사고 ID',
	Accident_damage_degree INT NOT NULL COMMENT '피해정도',
	Accident_date DATETIME NOT NULL COMMENT '발생 일자',
	Insurance_claim_check TINYINT(1) NOT NULL DEFAULT 0 COMMENT '보험청구여부',
	Accident_code VARCHAR(255) NOT NULL COMMENT '사고  코드',
	Car_ID INT NOT NULL COMMENT '자동차 ID',
	CONSTRAINT PK_ACCIDENT_HISTORY PRIMARY KEY (Accident_ID),
	CONSTRAINT FK_Accident_TO_Accident_History_1 FOREIGN KEY (Accident_code) REFERENCES Accident (Accident_code),
	CONSTRAINT FK_Inspection_record_TO_Accident_History_1 FOREIGN KEY (Car_ID) REFERENCES Car (Car_ID)
)COMMENT = '자동차침수이력';

CREATE TABLE Inundation (
	Inundation_ID INT	AUTO_INCREMENT COMMENT '차동자 침수 ID',
	Inundation_degree INT NOT NULL COMMENT '침수정도',
	Inundation_date DATETIME NOT NULL COMMENT '발생 일자',
	Accident_code VARCHAR(255)	NOT NULL COMMENT '사고  코드',
	Car_ID INT NOT NULL COMMENT '자동차 ID',
	CONSTRAINT PK_INUNDATION PRIMARY KEY (Inundation_ID),
	CONSTRAINT FK_Accident_TO_Inundation_1 FOREIGN KEY (Accident_code) REFERENCES Accident (Accident_code),
	CONSTRAINT FK_Inspection_record_TO_Inundation_1 FOREIGN KEY (Car_ID) REFERENCES Car (Car_ID)
)COMMENT = '자동차침수이력';

CREATE TABLE USER (
	User_ID	INT	PRIMARY KEY AUTO_INCREMENT COMMENT '회원ID',
	User_name	VARCHAR(255)	NOT NULL COMMENT '이름',
	User_nickname	VARCHAR(255)	NOT NULL COMMENT '닉네임',
	User_password	VARCHAR(255)	NOT NULL COMMENT '비밀번호',
	User_email	VARCHAR(255)	NOT NULL COMMENT '이메일',
	User_phoneNum	VARCHAR(255)	NOT NULL COMMENT '전화번호',
	User_address	VARCHAR(255)	NOT NULL COMMENT '주소',
	User_birth	DATETIME	NOT NULL COMMENT '생년월일',
	User_sign_up_date	DATETIME	NOT NULL COMMENT '가입일',
	User_coupon	INT	NULL	DEFAULT 0 COMMENT '보유 쿠폰',
	Dealer_company	VARCHAR(255)	NULL COMMENT '딜러 회사명',
	Dealer_region	VARCHAR(255)	NULL COMMENT '딜러 근무지',
	Dealer_grade	INT	NULL COMMENT '딜러 등급',
	User_type	INT	NOT NULL COMMENT '회원 유형',
	User_blacklist	TINYINT(1)	NULL	DEFAULT 0 COMMENT '블랙회원여부',
	Restriction_date	DATETIME	NULL COMMENT '제재 적용일',
	Restriction_end_date	DATETIME	NULL COMMENT '제재 종료일',
	Login_fail_stack	INT	NULL DEFAULT 0 COMMENT '로그인실패횟수',
	Report_issue_stack	INT	NULL DEFAULT 0 COMMENT '누적신고횟수',
	Login_restriction_check	TINYINT(1)	NULL	DEFAULT 0 COMMENT '접근제한여부',
	User_withdraw_check	TINYINT(1)	NULL	DEFAULT 0 COMMENT '탈퇴여부',
	User_withdraw_date DATE NULL COMMENT '탈퇴날짜'
)COMMENT = '회원';

CREATE TABLE Coupon (
	Coupon_number INT AUTO_INCREMENT COMMENT '쿠폰 번호',
	Coupon_date DATETIME NOT NULL COMMENT '발급 일자',
	Coupon_usage_status TINYINT(1) NOT NULL DEFAULT 0 COMMENT '쿠폰 사용 상태',
	Coupon_description TEXT NOT NULL COMMENT '쿠폰 설명',
	User_ID INT NOT NULL COMMENT '회원ID',
	CONSTRAINT PK_COUPON PRIMARY KEY (Coupon_number),
	CONSTRAINT FK_User_TO_Coupon_1 FOREIGN KEY (User_ID) REFERENCES User (User_ID)
)COMMENT = '쿠폰';

CREATE TABLE Login_log (
	Login_log_ID	INT AUTO_INCREMENT COMMENT '로그인내역ID',
	Success_check	TINYINT(1)	NOT NULL	DEFAULT 0 COMMENT '성공여부',
	Attempt_date	DATE	NOT NULL COMMENT '시도날짜',
	Attempt_time	TIME	NOT NULL COMMENT '시도시간',
	Attempt_region	VARCHAR(255)	NOT NULL COMMENT '시도위치',
	User_ID	INT	NOT NULL COMMENT '회원ID',
	CONSTRAINT pk_Login_log_ID PRIMARY KEY (Login_log_ID),
	CONSTRAINT fk_User_ID FOREIGN KEY (User_ID) REFERENCES User (User_ID)
) COMMENT = '로그인내역';


CREATE TABLE Report (
	Report_ID	INT AUTO_INCREMENT COMMENT '신고 ID',
	Report_type	VARCHAR(255)	NOT NULL COMMENT '신고 유형',
	Report_date	DATETIME	NOT NULL COMMENT '신고 일자',
	Punish_check	TINYINT(1)	NOT NULL	DEFAULT 0 COMMENT '처벌 여부',
	Report_substance	TEXT	NOT NULL COMMENT '신고 내용',
	Reporter_ID	INT	NOT NULL COMMENT '신고자 ID',
	Reported_ID	INT	NOT NULL COMMENT '피신고자 ID',
	CONSTRAINT pk_Report_ID PRIMARY KEY (Report_ID),
  CONSTRAINT fk_Reporter_ID FOREIGN KEY (Reporter_ID) REFERENCES User (User_ID),
	CONSTRAINT fk_Reported_ID FOREIGN KEY (Reported_ID) REFERENCES User (User_ID)
)COMMENT = '신고내역';

CREATE TABLE Penalty (
	Penalty_ID	INT AUTO_INCREMENT COMMENT '제재 내역 ID',
	Penalty_duration	DATETIME	NOT NULL COMMENT '제재 일자',
	Penalty_type	VARCHAR(255)	NOT NULL COMMENT '제재 유형',
	Penalty_reason	VARCHAR(255)	NOT NULL COMMENT '제재 사유',
	Penalty_applydate	DATETIME	NOT NULL COMMENT '제재 적용일',
	Penalty_enddate	DATETIME	NOT NULL COMMENT '제재 종료일',
	User_ID	INT	NOT NULL COMMENT '회원ID',
	CONSTRAINT pk_Penalty_ID PRIMARY KEY (Penalty_ID),
	CONSTRAINT fk_User_ID_1 FOREIGN KEY (User_ID) REFERENCES User (User_ID)
)COMMENT = '제재내역';


CREATE TABLE Notice (
	Notice_ID 	INT	AUTO_INCREMENT COMMENT '알림ID',
	Notice_type	VARCHAR(255)	NULL COMMENT '알림유형',
	Notice_description	TEXT	NULL COMMENT '알림설명',
   User_ID	INT	NOT NULL COMMENT '회원ID',
	CONSTRAINT pk_Notice_ID PRIMARY KEY (Notice_ID),
  CONSTRAINT fk_User_ID_n FOREIGN KEY (User_ID) REFERENCES User (User_ID)
) COMMENT = '알림';


CREATE TABLE Review (
	Review_ID	INT AUTO_INCREMENT COMMENT '리뷰내역ID',
	Review_contents	TEXT	Not NULL COMMENT '리뷰 내용',
	Review_grade	VARCHAR(255)	Not NULL COMMENT '평가 등급',
	User_ID	INT	NOT NULL COMMENT '회원ID',
  Dealer_ID INT NOT NULL COMMENT '판매자ID',
	CONSTRAINT pk_Review_ID PRIMARY KEY (Review_ID),
	CONSTRAINT fk_User_ID_3 FOREIGN KEY (User_ID) REFERENCES User (User_ID),
  CONSTRAINT fk_User_ID_d FOREIGN KEY (Dealer_ID) REFERENCES User (User_ID)
)COMMENT = '리뷰내역';


CREATE TABLE Board (
	Board_ID	INT	PRIMARY KEY AUTO_INCREMENT COMMENT '게시판ID',
	Board_type	VARCHAR(255)	NOT NULL COMMENT '게시판 유형',
	Board_description	TEXT	NOT NULL COMMENT '게시판 설명'
) COMMENT = '게시판';

CREATE TABLE Post (
	Post_ID	INT	PRIMARY KEY AUTO_INCREMENT COMMENT '게시물ID',
	Post_title	VARCHAR(255)	NOT NULL COMMENT '게시물 제목',
	Post_contents	TEXT	NOT NULL COMMENT '게시물 내용',
	Post_date	DATETIME	NOT NULL COMMENT '게시물 작성일',
	Post_hits	INT	NOT NULL	DEFAULT 0 COMMENT '조회수',
	Post_last_update	DATETIME	NOT NULL	DEFAULT NOW() COMMENT '마지막 업데이트',
	Post_type	VARCHAR(255)	NOT NULL COMMENT '게시물 유형',
	Deal_date	DATETIME	NULL COMMENT '판매 완료 일자',
	Report_check	TINYINT(1)	NOT NULL	DEFAULT 0 COMMENT '신고 여부',
	Car_ID	INT	NOT NULL COMMENT '차량ID',
	User_ID	INT	NOT NULL COMMENT '회원 ID',
	Board_ID	INT	NOT NULL COMMENT '게시판ID',
  FOREIGN KEY(Car_ID) References Car(Car_ID),
  FOREIGN KEY(User_ID) References User(User_ID),
  FOREIGN KEY(Board_ID) References Board(Board_ID)
) COMMENT = '게시물';


CREATE TABLE Payment_History (
	Payment_ID	INT	PRIMARY KEY AUTO_INCREMENT COMMENT '결제ID',
	Payment_date	DATETIME	NOT NULL COMMENT '결제일',
	Payment_method	VARCHAR(255)	NOT NULL COMMENT '결제수단',
	Payment_amount	INT	NOT NULL COMMENT '결제금액',
	Car_ID	INT	NOT NULL COMMENT '자동차 ID',
	User_ID	INT	NOT NULL COMMENT '회원ID',
  FOREIGN KEY(Car_ID) References Car(Car_ID),
  FOREIGN KEY(User_ID) References User(User_ID)
) COMMENT = '결제이력';

CREATE TABLE Interested_Car (
	Interested_Car_ID INT AUTO_INCREMENT COMMENT '구매관심차량ID',
	Post_ID INT NOT NULL COMMENT '게시물ID',
	User_ID INT NOT NULL COMMENT '회원ID',
	Chosen_time DATETIME NOT NULL COMMENT '찜한시간',
	CONSTRAINT PK_INTERESTED_CAR PRIMARY KEY (Interested_Car_ID),
	CONSTRAINT FK_Post_TO_Interested_Car_1 FOREIGN KEY (Post_ID) REFERENCES Post (Post_ID),
	CONSTRAINT FK_User_TO_Interested_Car_1 FOREIGN KEY (User_ID) REFERENCES User (User_ID)
) COMMENT = '구매관심차량';

CREATE TABLE Reservation (
	Reservation_ID INT AUTO_INCREMENT COMMENT '예약 ID',
	Reservation_status VARCHAR(255) NOT NULL COMMENT '예약상태',
	Reservation_purpose VARCHAR(255) NOT NULL COMMENT '예약목적',
	Reservation_date DATETIME	NOT NULL COMMENT '예약일자',
	Post_ID INT NOT NULL COMMENT '게시물ID',
	User_ID INT NOT NULL COMMENT '회원ID',
	CONSTRAINT PK_RESERVATION PRIMARY KEY (Reservation_ID),
	CONSTRAINT FK_Post_TO_Reservation_1 FOREIGN KEY (Post_ID) REFERENCES Post (Post_ID),
	CONSTRAINT FK_User_TO_Reservation_1 FOREIGN KEY (User_ID) REFERENCES User (User_ID)
) COMMENT = '예약내역';