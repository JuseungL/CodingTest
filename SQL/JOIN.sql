--MEMBER_PROFILE와 REST_REVIEW 테이블에서 리뷰를 가장 많이 작성한 회원의 리뷰들을 조회하는 SQL문을 작성해주세요. 회원 이름, 리뷰 텍스트, 리뷰 작성일이 출력되도록 작성해주시고, 결과는 리뷰 작성일을 기준으로 오름차순, 리뷰 작성일이 같다면 리뷰 텍스트를 기준으로 오름차순 정렬해주세요.
--그룹으로 묶어봤을 때 그 수가 가장 많은 회원 아이디를 빼와서 조건으러 걸었다.
SELECT p.MEMBER_NAME, r.REVIEW_TEXT, DATE_FORMAT(r.REVIEW_DATE,'%Y-%m-%d') AS REVIEW_DATE
FROM MEMBER_PROFILE as p
JOIN REST_REVIEW as r ON p.MEMBER_ID = r.MEMBER_ID
WHERE p.MEMBER_ID = (SELECT MEMBER_ID FROM REST_REVIEW
                    GROUP BY MEMBER_ID
                    ORDER BY COUNT(*) DESC 
                    LIMIT 1)
ORDER BY r.REVIEW_DATE ASC, r.REVIEW_TEXT ASC;

--FOOD_PRODUCT와 FOOD_ORDER 테이블에서 생산일자가 2022년 5월인 식품들의 식품 ID, 식품 이름, 총매출을 조회하는 SQL문을 작성해주세요. 이때 결과는 총매출을 기준으로 내림차순 정렬해주시고 총매출이 같다면 식품 ID를 기준으로 오름차순 정렬해주세요.
SELECT p.PRODUCT_ID, p.PRODUCT_NAME, SUM(p.PRICE*o.AMOUNT) AS TOTAL_SALES
FROM FOOD_PRODUCT p
JOIN FOOD_ORDER o ON p.PRODUCT_ID = o.PRODUCT_ID
WHERE o.PRODUCE_DATE LIKE '2022-05-%'
GROUP BY p.PRODUCT_ID
ORDER BY TOTAL_SALES DESC, p.PRODUCT_ID ASC;

--'경제' 카테고리에 속하는 도서들의 도서 ID(BOOK_ID), 저자명(AUTHOR_NAME), 출판일(PUBLISHED_DATE) 리스트를 출력하는 SQL문을 작성해주세요.결과는 출판일을 기준으로 오름차순 정렬해주세요.
SELECT b.BOOK_ID, a.AUTHOR_NAME, DATE_FORMAT(b.PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE
FROM BOOK b
JOIN AUTHOR a ON b.AUTHOR_ID = a.AUTHOR_ID
WHERE b.CATEGORY = '경제'
ORDER BY PUBLISHED_DATE ASC;

--7월 아이스크림 총 주문량과 상반기의 아이스크림 총 주문량을 더한 값이 큰 순서대로 상위 3개의 맛을 조회하는 SQL 문을 작성해주세요.
SELECT f.FLAVOR 
FROM FIRST_HALF f
JOIN JULY j ON f.FLAVOR = j.FLAVOR
GROUP BY f.FLAVOR
ORDER BY SUM(f.TOTAL_ORDER)+SUM(j.TOTAL_ORDER) DESC
LIMIT 3

--CAR_RENTAL_COMPANY_CAR 테이블과 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블과 CAR_RENTAL_COMPANY_DISCOUNT_PLAN 테이블에서 자동차 종류가 '세단' 또는 'SUV' 인 자동차 중 2022년 11월 1일부터 2022년 11월 30일까지 대여 가능하고 30일간의 대여 금액이 50만원 이상 200만원 미만인 자동차에 대해서 자동차 ID, 자동차 종류, 대여 금액(컬럼명: FEE) 리스트를 출력하는 SQL문을 작성해주세요. 결과는 대여 금액을 기준으로 내림차순 정렬하고, 대여 금액이 같은 경우 자동차 종류를 기준으로 오름차순 정렬, 자동차 종류까지 같은 경우 자동차 ID를 기준으로 내림차순 정렬해주세요.
SELECT C.CAR_ID, C.CAR_TYPE, ROUND(C.DAILY_FEE*30*(100-P.DISCOUNT_RATE)/100) AS FEE
FROM CAR_RENTAL_COMPANY_CAR AS C
JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY AS H ON C.CAR_ID=H.CAR_ID
JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN AS P ON C.CAR_TYPE=P.CAR_TYPE
WHERE C.CAR_ID NOT IN (
    SELECT CAR_ID
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    WHERE END_DATE > '2022-11-01' AND START_DATE < '2022-12-01'
) AND P.DURATION_TYPE='30일 이상'
GROUP BY C.CAR_ID
HAVING C.CAR_TYPE IN ('세단', 'SUV') AND (FEE>=500000 AND FEE<2000000) 
ORDER BY FEE DESC, CAR_TYPE, CAR_ID DESC

--천재지변으로 인해 일부 데이터가 유실되었습니다. 입양을 간 기록은 있는데, 보호소에 들어온 기록이 없는 동물의 ID와 이름을 ID 순으로 조회하는 SQL문을 작성해주세요.
--LEFT 또는 RIGHT JOIN으로 null값 찾기 두개 같은 결과
SELECT o.ANIMAL_ID, o.NAME
FROM ANIMAL_INS i
RIGHT JOIN ANIMAL_OUTS o ON i.ANIMAL_ID = o.ANIMAL_ID
WHERE i.ANIMAL_ID IS NULL

SELECT o.ANIMAL_ID, o.NAME
FROM ANIMAL_OUTS o 
LEFT JOIN ANIMAL_INS i ON o.ANIMAL_ID = i.ANIMAL_ID
WHERE i.ANIMAL_ID is NULL

--관리자의 실수로 일부 동물의 입양일이 잘못 입력되었습니다. 보호 시작일보다 입양일이 더 빠른 동물의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 시작일이 빠른 순으로 조회해야합니다.
SELECT i.ANIMAL_ID, i.NAME
FROM ANIMAL_INS i
JOIN ANIMAL_OUTS o ON i.ANIMAL_ID = o.ANIMAL_ID
WHERE i.DATETIME > o.DATETIME
ORDER BY i.DATETIME ASC;

--아직 입양을 못 간 동물 중, 가장 오래 보호소에 있었던 동물 3마리의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 시작일 순으로 조회해야 합니다.
--LEFT JOIN으로 아직 입양 못간 동물 null값으로 캐치
SELECT i.NAME, i.DATETIME
FROM ANIMAL_INS i
LEFT JOIN ANIMAL_OUTS o ON i.ANIMAL_ID = o.ANIMAL_ID
WHERE o.DATETIME IS NULL
ORDER BY i.DATETIME ASC
LIMIT 3;

--보호소에서 중성화 수술을 거친 동물 정보를 알아보려 합니다. 보호소에 들어올 당시에는 중성화1되지 않았지만, 보호소를 나갈 당시에는 중성화된 동물의 아이디와 생물 종, 이름을 조회하는 아이디 순으로 조회하는 SQL 문을 작성해주세요.
--수컷일 경우 Neutered, 암컷일 경우 Spayed, 중성화 전 일 경우 Intact
SELECT o.ANIMAL_ID, o.ANIMAL_TYPE, o.NAME
FROM ANIMAL_INS i
JOIN ANIMAL_OUTS o ON i.ANIMAL_ID = o.ANIMAL_ID
WHERE i.SEX_UPON_INTAKE LIKE 'Intact%'
    AND (o.SEX_UPON_OUTCOME LIKE 'Spayed%'
        OR o.SEX_UPON_OUTCOME LIKE 'Neutered%')
ORDER BY o.ANIMAL_ID;

--PRODUCT 테이블과 OFFLINE_SALE 테이블에서 상품코드 별 매출액(판매가 * 판매량) 합계를 출력하는 SQL문을 작성해주세요. 결과는 매출액을 기준으로 내림차순 정렬해주시고 매출액이 같다면 상품코드를 기준으로 오름차순 정렬해주세요.
SELECT p.PRODUCT_CODE, SUM(p.PRICE * s.SALES_AMOUNT) AS SALES
FROM PRODUCT p 
JOIN OFFLINE_SALE s ON p.PRODUCT_ID = s.PRODUCT_ID
GROUP BY PRODUCT_CODE
ORDER BY SALES DESC, PRODUCT_CODE ASC;

--USER_INFO 테이블과 ONLINE_SALE 테이블에서 2021년에 가입한 전체 회원들 중 상품을 구매한 회원수와 상품을 구매한 회원의 비율(=2021년에 가입한 회원 중 상품을 구매한 회원수 / 2021년에 가입한 전체 회원 수)을 년, 월 별로 출력하는 SQL문을 작성해주세요. 상품을 구매한 회원의 비율은 소수점 두번째자리에서 반올림하고, 전체 결과는 년을 기준으로 오름차순 정렬해주시고 년이 같다면 월을 기준으로 오름차순 정렬해주세요.
--Count셀때 SELECT안에서도 SELECT(COUNT(*))이런식으로 셀수있어.
SELECT YEAR(s.SALES_DATE) AS YEAR,
        MONTH(s.SALES_DATE) AS MONTH, 
        COUNT(DISTINCT s.USER_ID) AS PURCHASED_USERS, 
        ROUND((COUNT(DISTINCT s.USER_ID) / (SELECT COUNT(*) FROM USER_INFO WHERE YEAR(JOINED) = 2021)),1) AS PURCHASED_RATIO
FROM USER_INFO i  
JOIN  ONLINE_SALE s ON i. USER_ID = s.USER_ID
WHERE YEAR(i.JOINED) = 2021
GROUP BY YEAR, MONTH
ORDER BY YEAR ASC, MONTH ASC;