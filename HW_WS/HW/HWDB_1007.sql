create database hwdb;

use hwdb;

drop table product;

-- 1. 상품정보를 저장할 수 있는 테이블을 구성하여 보자. 
--    (상품코드, 상품명, 상품가격 등)
create table `product` (
	`PRODUCT_NO` int(10),
    `PRODUCT_NAME` VARCHAR(100) NOT NULL,
    `PRODUCT_PRICE` VARCHAR(100) NOT NULL
    );

ALTER TABLE PRODUCT ADD CONSTRAINT `PRODUCT_PK` primary key(PRODUCT_NO);

-- 2. 상품 데이터를 5개 이상 저장하는 SQL을 작성하여 보자.
--    (상품명에 TV, 노트북 포함 하도록 하여 5개 이상)
INSERT INTO PRODUCT VALUES
	('1000', 'SAMSUNG_TV', '1000000'),
    ('2000', 'SAMSUNG_NOTEBOOK', '2000000'),
    ('3000', 'SAMSUNG_REFRIGERATOR', '3000000'),
    ('4000', 'SAMSUNG_SMARTPHONE', '4000000'),
    ('5000', 'SAMSUNG_TAB', '5000000');

select * from PRODUCT;
-- 3. 상품을 세일하려고 한다.   15% 인하된 가격의 상품 정보를 출력하세요.
SELECT PRODUCT_NO AS NO, PRODUCT_NAME AS NAME, PRODUCT_PRICE*0.85 AS PRICE FROM PRODUCT;
select * from PRODUCT;

-- 4. TV 관련 상품을 가격을 20% 인하하여 저장하세요. 그 결과를 출력하세요.
UPDATE PRODUCT SET PRODUCT_PRICE = PRODUCT_PRICE * 0.8 WHERE PRODUCT_NAME LIKE '%TV%';
select * from PRODUCT;

-- 5. 저장된 상품 가격의 총 금액을 출력하는 SQL 문장을 작성하세요.
SELECT SUM(PRODUCT_PRICE) FROM PRODUCT;