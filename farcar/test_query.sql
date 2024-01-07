-- Model insert
SELECT * FROM model;
INSERT INTO model (
    Model_ID,
    Model_name,
    Model_description
)
VALUES 
(   'M1',
    '경형',
    '엔진 배기량이 1,000cc 미만의 승용차'
),
(   'M2',
    '소형',
    '엔진 배기량 1,600cc 미만의 승용차'
),
(   'M3',
    '중형',
    '배기량 1,600cc 이상 2,000cc 미만의 승용차	'
),
(   'MF',
    '대형',
    '배기량 2,000cc 이상의 승용차'
),
(   'M5',
    '스포츠카',
    '스피드를 높이는 데에 중점을 두어 만든 오락용ㆍ경주용 자동차.'
);
SELECT * FROM model;

-- Car insert
SELECT * FROM Car;
INSERT INTO Car (
    Car_field,
    Car_model,
    Car_year,
    Car_mileage,
    Car_condition,
    Car_transmission,
    Car_oiltype,
    Car_engine,
    Car_fuel_efficiency,
    Accident_check,
    Inundation_check,
    Selling_price,
    Picture_URL,
    Picture_origin,
    Picture_rename,
    Model_ID,
    Insepction_record_URL
)
VALUES(
    '경차',
    '황금 마티즈',
    2003,
    250000,
    '나쁨',
    'Auto',
    '휘발유',
    '2.0L 터보',
    10,
    12,
    3,
    600000,
    '/이미지/Golden Matiz.jpg',
    '원본',
    '변경된이름',
    'M1',
    'https://kor.pngtree.com/freepng/vector-for-cute-carrot-character_7267878.html'
),
(
    '소형차',
    'Volvo EX30',
    2024,
    70000,
    '우수',
    '자동1단',
    '전기',
    '익시드 엔진',
    25,
    0,
    0,
    49000000,
    '/이미지/Volvo EX30.jpg',
    '원본',
    '변경된이름',
    'M2',
    'https://kor.pngtree.com/freepng/vector-for-cute-carrot-character_7267878.html'
),
(
    '중형차',
    'JEEP 랭글러 2도어',
    2015,
    30000,
    '보통',
    'Auto8',
    '가솔린',
    'L4 싱글터보',
    8,
    2,
    0,
    65000000,
    '/이미지/JEEP Wrangler 2Door.jpg',
    '원본',
    '변경된이름',
    'M3',
    'https://kor.pngtree.com/freepng/vector-for-cute-carrot-character_7267878.html'
), 
(
    '대형차',
    'Tesla 사이버트럭',
    2021,
    80000,
    '우수',
    'Auto1',
    '전기',
    'X엔진',
    24,
    1,
    1,
    115000000,
    '/이미지/Tesla CyberTruck.jpg',
    '원본',
    '변경된이름',
    'MF',
    'https://kor.pngtree.com/freepng/vector-for-cute-carrot-character_7267878.html'
),
(
    '스포츠차',
    'McLaren GTS',
    2023,
    40000,
    '매우 우수',
    'Auto7',
    '가솔린',
    'V8',
    12,
    4,
    0,
    515000000,
    '/이미지/McLaren GTS.jpg',
    '원본',
    '변경된이름',
    'M5',
    'https://kor.pngtree.com/freepng/vector-for-cute-carrot-character_7267878.html'
);
SELECT * FROM Car;

-- Ownership_history
SELECT * FROM Ownership_history;
INSERT INTO Ownership_history (
    Previous_Owner,
    Current_Owner,
    Ownership_start,
    Ownership_end,
    Reason_transfer,
    Descript_transfer,
    Car_ID
)
VALUES 
(
    '이재원',
    '이준형',
    '2021-04-03 09:00:00',
    '2023-03-15 17:30:00',
    '직장 지역이동에 의한 판매',
    '차량 상태 우수, 주행거리 낮음',
    4
),
(
    '이재원',
    '이준형',
    '2022-06-02 09:00:00',
    '2023-07-15 17:30:00',
    '이직에 의한 판매',
    '차량 상태 우수, 주행거리 낮음',
    1
),
(
    '송동준',
    '최종찬',
    '2023-08-027 13:00:00',
    '2023-09-25 03:30:00',
    '이사에 의한 판매',
    '차량 상태 매우 우수, 주행거리 매우 낮음',
    2
),
(
    '신동호',
    '정태원',
    '2015-12-01 21:00:00',
    '2019-05-13 12:30:00',
    '군대가야돼서 판매',
    '차량 상태 보통, 주행거리 매우 낮음',
    3
);
SELECT * FROM Ownership_history;


-- Accident insert
-- FACD = Front Accident 줄임말
SELECT * FROM Accident;
INSERT INTO Accident (
    Accident_code,
    Accident_type,
    Accident_description
)
VALUES 
(
    'FACD001',
    '전방 충돌사고',
    '차량이 앞에 지나가는 차와 충돌하여 발생한 교통사고'
),
(
    'BACD001',
    '후방 충돌사고',
    '뒤쪽 차량이 앞에 지나가는 차와 충돌하여 발생한 교통사고'
),
(
    'HACD001',
    '고속도로사고',
    '비교적 빠른 속도로 운전을 하는 차량들 사이의 충돌 및 교통 체증으로 인한 사고를 포함합니다.'
),
(
    'UACD001',
    '기타사고',
    '추돌, 횡단보도 사고, 도로 위의 물체에 충돌하는 사고 등 다양한 상황에서 발생하는 사고들입니다.'
),
(
    'DACD001',
    '침수사고',
    '숨참고 러브다이브'
);
SELECT * FROM Accident;

-- Accident_History insert
SELECT * FROM Accident_History;
INSERT INTO Accident_History (
    Accident_damage_degree,
    Accident_date,
    Insurance_claim_check,
    Accident_code,
    Car_ID
)
VALUES 
(
    2,
    '2023-05-20 16:00:00',
    1,
    'FACD001',
    1
),
(
    4,
    '2021-11-11 11:11:00',
    0,
    'BACD001',
    2
),
(
    7,
    '2024-01-01 00:00:00',
    0,
    'UACD001',
    4
);
SELECT * FROM Accident_History;

-- Inundation insert
SELECT * from Inundation;
INSERT INTO Inundation (
    Inundation_degree,
    Inundation_date,
    Accident_code,
    Car_ID
)
VALUES 
(
    3,
    '2023-07-10 10:15:00',
    'DACD001',
    1
),
(
    6,
    '2021-01-10 15:15:00',
    'DACD001',
    4
),
(
    1,
    '2015-05-13 13:15:00',
    'DACD001',
    1
);
SELECT * from Inundation;

-- User insert
SELECT * FROM user;
INSERT INTO User (
	User_ID,
	User_name,
	User_nickname,
	User_password,
	User_email,
	User_phoneNum,
	User_address,
	User_birth,
	User_sign_up_date,
	User_coupon,
	Dealer_company,
	Dealer_region,
	Dealer_grade,
	User_type,
	User_blacklist,
	Restriction_date,
	Restriction_end_date,
	Login_fail_stack,
	Report_issue_stack,
	Login_restriction_check,
	User_withdraw_check,
	User_withdraw_date 
)
VALUES 
(
 NULL, 
 '이름요',
 '딜러임요',
 '비번입니다',
 'mail@daum.net',
 '010-5555-5555',
 '부산',
 '2023-1-3 00:00:00',
  NOW(),
  NULL,	-- 보유쿠폰
  '회사요',	
  '근무지요',  
  1,	-- 딜러등급
  1,	-- 회원유형 1=판매자 0=구매자
  NULL,	-- 블랙 여부
  NULL,	-- 제재 시작일
  NULL,	-- 제재 종료일
  NULL,	-- 로그인 실패 횟수
  NULL,	-- 누적 신고 횟수
  NULL,	-- 로그인 제한 여부
  0,	-- 탈퇴여부
  NULL -- 탈퇴날짜
),
(
 NULL, 
 '이름요',
 '회원임요',
 '비번입니다',
 'mail@daum.net',
 '010-5445-5555',
 '서울',
 '2023-1-3 00:00:00',
  NOW(),
  NULL,	-- 보유쿠폰`user`
  NULL,	
  NULL,  
  NULL,	-- 딜러등급
  0,	-- 회원유형 1=판매자 0=구매자
  NULL,	-- 블랙 여부
  NULL,	-- 제재 시작일
  NULL,	-- 제재 종료일
  NULL,	-- 로그인 실패 횟수
  NULL,	-- 누적 신고 횟수
  NULL,	-- 로그인 제한 여부
  0,	-- 탈퇴여부
  NULL -- 탈퇴날짜
),
(
 NULL, 
 '이름요',
 '회원임요',
 '비번입니다',
 'mail@daum.net',
 '010-5445-5555',
 '서울',
 '2023-1-3 00:00:00',
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
  NULL,	-- 누적 신고 횟수
  NULL,	-- 로그인 제한 여부
  0,	-- 탈퇴여부
  NULL -- 탈퇴날짜
),
(
 NULL, 
 '이름요',
 '회원임요',
 '비번입니다',
 'mail@daum.net',
 '010-5445-5555',
 '서울',
 '2023-1-3 00:00:00',
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
  NULL,	-- 누적 신고 횟수
  NULL,	-- 로그인 제한 여부
  0,	-- 탈퇴여부
  NULL -- 탈퇴날짜
),
(
 NULL, 
 '이름요',
 '회원임요',
 '비번입니다',
 'mail@daum.net',
 '010-5445-5555',
 '서울',
 '2023-1-3 00:00:00',
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
  NULL,	-- 누적 신고 횟수
  NULL,	-- 로그인 제한 여부
  0,	-- 탈퇴여부
  NULL -- 탈퇴날짜
);
SELECT * FROM user;

-- Coupon insert
SELECT * FROM Coupon;
INSERT INTO coupon (
    Coupon_date,
    Coupon_usage_status,
    Coupon_description,
    User_ID
)
VALUES 
(
    '2023-08-20 15:00:00',
    0,
    '첫 구매자를 위한 할인 쿠폰',
    4
), 
(
    '2022-04-05 11:00:00',
    1,
    '첫 구매자를 위한 할인 쿠폰',
    2
), 
(
    '2022-11-21 21:00:00',
    1,
    '빼빼로데이기념 수수료면제 쿠폰',
    1
),
(
    '2021-01-17 21:00:00',
    1,
    '2020크리스마스 수수료면제 쿠폰',
    5
),
(
    '2024-01-03 09:00:00',
    0,
    '갑진년 청룡의 새해맞이 수수료면제 쿠폰',
    3
);
SELECT * FROM Coupon;

-- Login_log insert
SELECT * FROM Login_log;
INSERT INTO Login_log (
    Success_check,
    Attempt_date,
    Attempt_time,
    Attempt_region,
    User_ID
)
VALUES 
(
    1,
    '2023-10-10',
    '09:45:00',
    '서울',
    4
),
(
    0,
    '2024-01-01',
    '16:15:00',
    '개성',
    1
),
(
    1,
    '2022-02-02',
    '02:02:00',
    '동경',
    3
);
SELECT * FROM Login_log;

-- Report insert
SELECT * FROM Report;
INSERT INTO Report (
    Report_type,
    Report_date,
    Punish_check,
    Report_substance,
    Reporter_ID,
    Reported_ID
)
VALUES 
(
    '부적절한 게시물 신고',
    '2023-11-05 17:20:00',
    0,
    '중고차 관련이 아닌 불법 광고를 함',
    1,
    2
),
(
    '불법 관련 신고',
    '2022-08-20 18:50:00',
    1,
    '허위매물을 올려놓음',
    4,
    3
),
(
    '조작 및 사기',
    '2024-01-01 10:45:00',
    0,
    '거래 당일 딜러와 만났으나 갑자기 거래 가격을 바꾸자, 성능점검기록부와 차의 현 성능이 다르다고 이제와서 통보함',
    5,
    3
);
SELECT * FROM Report;


-- Penalty insert
SELECT * FROM Penalty;
INSERT INTO Penalty (
    Penalty_duration,
    Penalty_type,
    Penalty_reason,
    Penalty_applydate,
    Penalty_enddate,
    User_ID
)
VALUES 
(
    '2022-10-01 00:00:00',
    '천년 정지',
    '부적절한 게시물',
    '2022-10-01 00:00:00',
    '3022-09-30 23:59:59',
    2
),
(
    '2022-09-07 00:00:00',
    '2천년 정지',
    '불법 게시물 신고',
    '2023-02-11 00:00:00',
    '4023-02-10 23:59:59',
    1
);
SELECT * FROM Penalty;

-- Notice insert
SELECT * FROM Notice;
INSERT INTO Notice (
    Notice_type,
    Notice_description,
    User_ID
)
VALUES 
(
    '이벤트 알림',
    '갑진년 새해 맞이 쿠폰 이벤트 진행중! 지금 사이트 이용 후기를 남기면 모두에게 증정!',
    4
),
(
    '가격 변동 알림',
    '회원님이 관심등록하신 차량의 가격이 변동되었습니다.',
    3
),
(
    '리뷰 알림',
    '최근 거래의 구매자 회원님께서 리뷰를 남기셨어요! 확인해보세요!',
    2
),
(
    '점검 공지',
    '금일 오후 9시부터 명일 오전 3시까지 사이트 점검으로 이용이 불가합니다.',
    1
);
SELECT * FROM Notice;


-- Review insert
SELECT * FROM Review;
INSERT INTO Review (
    Review_contents,
    Review_grade,
    User_ID,
    Dealer_ID
)
VALUES 
(
    '역시 좋네요. 믿고 있었다구',
    '5점',
    4,
    2
), 
(
    '흠....',
    '2점',
    3,
    1
),
(
    '차는 다 만족했는데 딜러가 너무 싸가지가 없네요 맞짱뜨고싶었어요',
    '1점',
    5,
    2
),
(
    '감사합니다~많이 파세요~',
    '3점',
    2,
    2
);
SELECT * FROM Review;


-- Board insert
INSERT INTO Board (
    Board_type,
    Board_description
)
VALUES 
(
    '공지사항 게시판',
    '서비스에 대한 공지 및 업데이트 사항을 안내합니다.'
),
(
    '차량 정보 게시판',
    '차량에 대한 정보 및 정보 공유를 할 수 있습니다. '
), 
(
    '거래 게시판',
    '차량 거래, 관심차량 등록 , 예약 등을 할 수 있습니다.'
);
SELECT * FROM Board;

-- Post insert
SELECT * FROM post;
INSERT INTO Post (
    Post_title,
    Post_contents,
    Post_date,
    Post_hits,
    Post_last_update,
    Post_type,
    Deal_date,
    Report_check,
    Car_ID,
    User_ID,
    Board_ID
)
VALUES 
(
    '황금마티즈 팝니다',
    '추억의 황금마티즈 맛좀 보고싶으신분 바로 연락주세요. 쿨거시 네고 가능',
    '2023-12-01 14:30:00',
    53,
    '2023-12-01 14:30:00',
    '판매',
    NULL,
    4,
    1,
    3,
    3
),
(
    '신차 볼보 EX30 타보시거나 타시는 분 계신가요?',
    '살까 말까 고민중인데 타보신분 계시면 실제로 어떤지 장단점 알려주세요!',
    '2024-01-03 17:30:00',
    132,
    '2023-01-03 17:30:00',
    '차량 정보',
    NULL,
    0,
    2,
    5,
    1
);
SELECT * FROM post;

-- Payment_History insert
SELECT * FROM payment_history;
INSERT INTO payment_history(
	payment_ID
,	payment_date
,	payment_method
,	payment_amount
,	Car_ID
,	User_ID
)
VALUES
(
	NULL
,	NOW()
,	'Card'
,	30000000
,	2
,	3
);
SELECT * FROM payment_history;

-- Interested_Car insert
SELECT * FROM Interested_Car;
INSERT INTO Interested_Car(
	interested_Car_ID
,	Post_ID
,	User_ID
,	Chosen_time
)
VALUES
(
	NULL
,	2
,	1
,	NOW()
);
SELECT * FROM interested_car;


-- Reservation insert
SELECT * FROM Reservation;
INSERT INTO Reservation(
	Reservation_ID
,	Reservation_status
,	Reservation_purpose
,	Reservation_date
,	post_ID
,	User_ID
)
VALUES
(	
	NULL
,	'예약 중'
,	'시승'
,	'2022-09-07'
,	2
,	4
);
SELECT * FROM Reservation;
