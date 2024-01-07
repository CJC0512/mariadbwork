SELECT * FROM car;
-- Transaction 시작
START TRANSACTION;

-- 예시: 자동차 정보 삽입
INSERT INTO Car (
	  Car_ID, Car_field, Car_model, Car_year, Car_mileage, Car_condition, 
	  Car_transmission, Car_oiltype, Car_engine, Car_fuel_efficiency,
	  Accident_check, Inundation_check, Selling_price, Picture_URL, 
	  Picture_origin, Picture_rename, Model_ID, Insepction_record_URL
)
VALUES 
(
	 99, 'Hyundai', 'Sonata', 2019, 50000, 'Good', 'Automatic', 
	 'Gasoline', '2.0L', 15, 0, 0, 20000, '/images/sonata.jpg', 
	 'sonata_original.jpg', 'sonata_rename.jpg', 'M2', '/inspection/M2'
);

-- 다른 테이블에도 삽입 또는 업데이트 등 필요한 작업 수행
-- Ownership_history insert
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
    99
);

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
    '2022-05-20 16:00:00',
    1,
    'FACD001',
    99
);

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
    '2022-07-10 10:15:00',
    'DACD001',
    99
);

-- Transaction 종료
COMMIT;
SELECT * FROM car WHERE car_id = 99;
SELECT * FROM accident_history WHERE car_id = 99;
SELECT * FROM inundation WHERE car_id = 99;