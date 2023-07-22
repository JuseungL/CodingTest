--CAR_RENTAL_COMPANY_CAR 테이블에서 '통풍시트', '열선시트', '가죽시트' 중 하나 이상의 옵션이 포함된 자동차가 자동차 종류 별로 몇 대인지 출력하는 SQL문을 작성해주세요. 이때 자동차 수에 대한 컬럼명은 CARS로 지정하고, 결과는 자동차 종류를 기준으로 오름차순 정렬해주세요.
-- 'IN' 연산자는 패턴 일치에 '%'를 사용하는 것과 같은 부분 일치가 아니라 정확한 일치를 확인하기 때문에 이 경우에 적합하지 않습니다 따라서 OPTIONS IN('%열선시트%', '%통풍시트%', '%가죽시트%') 불가능
SELECT CAR_TYPE, COUNT(*) AS CARS
FROM CAR_RENTAL_COMPANY_CAR
WHERE OPTIONS LIKE '%열선시트%' 
    OR OPTIONS LIKE '%통풍시트%' 
    OR OPTIONS LIKE '%가죽시트%'
GROUP BY CAR_TYPE
ORDER BY CAR_TYPE ASC;

--동물 보호소에 들어온 동물 중 고양이와 개가 각각 몇 마리인지 조회하는 SQL문을 작성해주세요. 이때 고양이를 개보다 먼저 조회해주세요.
SELECT ANIMAL_TYPE, COUNT(ANIMAL_TYPE) AS COUNT
FROM ANIMAL_INS
GROUP BY ANIMAL_TYPE
ORDER BY ANIMAL_TYPE ASC;

--상반기 동안 각 아이스크림 성분 타입과 성분 타입에 대한 아이스크림의 총주문량을 총주문량이 작은 순서대로 조회하는 SQL 문을 작성해주세요. 이때 총주문량을 나타내는 컬럼명은 TOTAL_ORDER로 지정해주세요.
SELECT i.INGREDIENT_TYPE, SUM(TOTAL_ORDER) AS TOTAL_ORDER
FROM FIRST_HALF AS f
JOIN ICECREAM_INFO AS i ON f.FLAVOR = i.FLAVOR
GROUP BY i.INGREDIENT_TYPE
ORDER BY TOTAL_ORDER ASC;

--REST_INFO 테이블에서 음식종류별로 즐겨찾기수가 가장 많은 식당의 음식 종류, ID, 식당 이름, 즐겨찾기수를 조회하는 SQL문을 작성해주세요. 이때 결과는 음식 종류를 기준으로 내림차순 정렬해주세요.
--HAVING은 GROUP BY가 된 후 작동하기 때문에 서브 쿼리를 작성하여 최대를 구한다. 
--복습 필수
SELECT FOOD_TYPE, REST_ID, REST_NAME, FAVORITES
FROM REST_INFO
WHERE (FOOD_TYPE, FAVORITES) IN (
                                SELECT FOOD_TYPE, MAX(FAVORITES)
                                FROM REST_INFO
                                GROUP BY FOOD_TYPE)
ORDER BY FOOD_TYPE DESC;


--USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서 완료된 중고 거래의 총금액이 70만 원 이상인 사람의 회원 ID, 닉네임, 총거래금액을 조회하는 SQL문을 작성해주세요. 결과는 총거래금액을 기준으로 오름차순 정렬해주세요
SELECT u.USER_ID, u.NICKNAME, SUM(PRICE) AS TOTAL_SALES
FROM USED_GOODS_BOARD AS b
JOIN USED_GOODS_USER AS u ON b.WRITER_ID = u.USER_ID
WHERE STATUS = 'DONE'
GROUP BY u.USER_ID
HAVING TOTAL_SALES >= 700000
ORDER BY TOTAL_SALES

--2022년 1월의 카테고리 별 도서 판매량을 합산하고, 카테고리(CATEGORY), 총 판매량(TOTAL_SALES) 리스트를 출력하는 SQL문을 작성해주세요.결과는 카테고리명을 기준으로 오름차순 정렬해주세요.
SELECT b.CATEGORY, SUM(SALES) AS TOTAL_SALES
FROM BOOK AS b
JOIN BOOK_SALES AS s ON b.BOOK_ID = s.BOOK_ID
WHERE s.SALES_DATE LIKE'2022-01-%'
GROUP BY CATEGORY
ORDER BY b.CATEGORY ASC;

--APPOINTMENT 테이블에서 2022년 5월에 예약한 환자 수를 진료과코드 별로 조회하는 SQL문을 작성해주세요. 이때, 컬럼명은 '진료과 코드', '5월예약건수'로 지정해주시고 결과는 진료과별 예약한 환자 수를 기준으로 오름차순 정렬하고, 예약한 환자 수가 같다면 진료과 코드를 기준으로 오름차순 정렬해주세요.
-- '5월예약건수' ASC, '진료과코드' ASC;로 하면 안돼!
-- 5월예약건수 ASC, 진료과코드 ASC; 이렇게 ''빼고 해야하한다.
SELECT MCDP_CD AS '진료과코드', COUNT(*) AS '5월예약건수'
FROM APPOINTMENT
WHERE APNT_YMD LIKE '2022-05-%'
GROUP BY MCDP_CD
ORDER BY 5월예약건수 ASC, 진료과코드 ASC;

--CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 2022년 10월 16일에 대여 중인 자동차인 경우 '대여중' 이라고 표시하고, 대여 중이지 않은 자동차인 경우 '대여 가능'을 표시하는 컬럼(컬럼명: AVAILABILITY)을 추가하여 자동차 ID와 AVAILABILITY 리스트를 출력하는 SQL문을 작성해주세요. 이때 반납 날짜가 2022년 10월 16일인 경우에도 '대여중'으로 표시해주시고 결과는 자동차 ID를 기준으로 내림차순 정렬해주세요.
--id가 고유한게 아니라 여러게 있으니까 16일이 Start~end사이에 있는 기록이 남아있는 id가 존재할 경우 해당 id의 차는 대여중이라고 표시하기 위해
SELECT CAR_ID, 
    CASE
        WHEN CAR_ID IN (SELECT CAR_ID
                        FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
                        WHERE '2022-10-16' BETWEEN START_DATE AND END_DATE) THEN '대여중'
        ELSE '대여 가능'
    END "AVAILABILITY"
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY CAR_ID
ORDER BY CAR_ID DESC

--FOOD_PRODUCT 테이블에서 식품분류별로 가격이 제일 비싼 식품의 분류, 가격, 이름을 조회하는 SQL문을 작성해주세요. 이때 식품분류가 '과자', '국', '김치', '식용유'인 경우만 출력시켜 주시고 결과는 식품 가격을 기준으로 내림차순 정렬해주세요.
--서브쿼리 쓰는 이유 탐구
SELECT CATEGORY, PRICE AS MAX_PRICE, PRODUCT_NAME
FROM FOOD_PRODUCT
WHERE (CATEGORY, PRICE) IN (SELECT CATEGORY, MAX(PRICE) 
                            FROM FOOD_PRODUCT 
                            GROUP BY CATEGORY)
GROUP BY CATEGORY
HAVING CATEGORY IN ('과자', '국', '김치', '식용유')
ORDER BY PRICE DESC;

--CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 대여 시작일을 기준으로 2022년 8월부터 2022년 10월까지 총 대여 횟수가 5회 이상인 자동차들에 대해서 해당 기간 동안의 월별 자동차 ID 별 총 대여 횟수(컬럼명: RECORDS) 리스트를 출력하는 SQL문을 작성해주세요. 결과는 월을 기준으로 오름차순 정렬하고, 월이 같다면 자동차 ID를 기준으로 내림차순 정렬해주세요. 특정 월의 총 대여 횟수가 0인 경우에는 결과에서 제외해주세요.
-- 복습필요
SELECT MONTH(START_DATE) AS MONTH, CAR_ID, COUNT(HISTORY_ID) AS RECORDS
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE CAR_ID IN (
        SELECT CAR_ID
        FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
        WHERE (DATE_FORMAT(START_DATE, '%Y-%m') BETWEEN '2022-08' AND '2022-10')
        GROUP BY CAR_ID
        HAVING COUNT(CAR_ID) >= 5
    ) AND (DATE_FORMAT(START_DATE, '%Y-%m') BETWEEN '2022-08' AND '2022-10')
GROUP BY MONTH, CAR_ID
HAVING RECORDS > 0
ORDER BY MONTH ASC, CAR_ID DESC;


--동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하는 SQL문을 작성해주세요. 이때 결과는 이름이 없는 동물은 집계에서 제외하며, 결과는 이름 순으로 조회해주세요.
SELECT NAME, COUNT(NAME) AS COUNT
FROM ANIMAL_INS
GROUP BY NAME
HAVING COUNT(NAME) >= 2
    AND NAME IS NOT NULL 
ORDER BY NAME ASC;

--USER_INFO 테이블과 ONLINE_SALE 테이블에서 년, 월, 성별 별로 상품을 구매한 회원수를 집계하는 SQL문을 작성해주세요. 결과는 년, 월, 성별을 기준으로 오름차순 정렬해주세요. 이때, 성별 정보가 없는 경우 결과에서 제외해주세요
--DISTINCT 을 이용하여 중복을 제거한다 이는 sales테이블은 하나의 판매데이터만 존재한다고 하지만 (year, month, gender, user_id)로 쿼리를 뽑아냈을떄 동일한 행이 나온다는 보장이 없기떄문에 이다 
SELECT YEAR(s.SALES_DATE) AS YEAR, MONTH(s.SALES_DATE) AS MONTH, u.GENDER, COUNT(DISTINCT u.USER_ID) AS USERS
FROM USER_INFO AS u
JOIN ONLINE_SALE AS s ON u.USER_ID = s.USER_ID
WHERE u.GENDER IS NOT NULL
GROUP BY YEAR(s.SALES_DATE), MONTH(s.SALES_DATE), u.GENDER
ORDER BY YEAR(s.SALES_DATE), MONTH(s.SALES_DATE), u.GENDER

--보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 09:00부터 19:59까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.
SELECT HOUR(DATETIME) AS HOUR, COUNT(*) AS COUNT
FROM ANIMAL_OUTS
GROUP BY HOUR(DATETIME)
HAVING HOUR >= 9 
    AND HOUR < 20
ORDER BY HOUR(DATETIME);


SELECT HOUR(DATETIME) AS HOUR, COUNT(DATETIME) COUNT
FROM ANIMAL_OUTS
WHERE HOUR(DATETIME) >= 9 AND HOUR(DATETIME) <= 19
GROUP BY HOUR(DATETIME);

--보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 0시부터 23시까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.
-- 쿼리문에서 로컬 변수를 활용하는 문제
SET @hour := -1; -- 변수 선언

SELECT (@hour := @hour + 1) as HOUR,
(SELECT COUNT(*) FROM ANIMAL_OUTS WHERE HOUR(DATETIME) = @hour) as COUNT
FROM ANIMAL_OUTS
WHERE @hour < 23

--PRODUCT 테이블에서 만원 단위의 가격대 별로 상품 개수를 출력하는 SQL 문을 작성해주세요. 이때 컬럼명은 각각 컬럼명은 PRICE_GROUP, PRODUCTS로 지정해주시고 가격대 정보는 각 구간의 최소금액(10,000원 이상 ~ 20,000 미만인 구간인 경우 10,000)으로 표시해주세요. 결과는 가격대를 기준으로 오름차순 정렬해주세요.
--10000원 이상은 천원 단위 이하로는 그냥 다 잘라버려서 0이다. TRUNCATE(PRICE, -4)하면 뒤에서 4번째부터 다 잘라버림
SELECT 
    CASE
        WHEN PRICE < 10000 THEN 0
        ELSE TRUNCATE(PRICE, -4)
    END AS PRICE_GROUP
    , COUNT(*) AS PRODUCTS
FROM PRODUCT
GROUP BY PRICE_GROUP
ORDER BY PRICE_GROUP;