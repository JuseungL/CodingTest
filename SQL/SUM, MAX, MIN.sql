--FOOD_PRODUCT 테이블에서 가격이 제일 비싼 식품의 식품 ID, 식품 이름, 식품 코드, 식품분류, 식품 가격을 조회하는 SQL문을 작성해주세요.
SELECT *
FROM FOOD_PRODUCT
WHERE PRICE = (
    SELECT MAX(PRICE)
    FROM FOOD_PRODUCT
);

--PRODUCT 테이블에서 판매 중인 상품 중 가장 높은 판ㅎ매가를 출력하는 SQL문을 작성해주세요. 이때 컬럼명은 MAX_PRICE로 지정해주세요.
SELECT MAX(PRICE) AS MAX_PRICE로
FROM PRODUCT

--가장 최근에 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
SELECT DATETIME AS 시간
FROM ANIMAL_INS
WHERE DATETIME = (
    SELECT MAX(DATETIME)
    FROM ANIMAL_INS
)

--동물 보호소에 가장 먼저 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
SELECT DATETIME AS 시간
FROM ANIMAL_INS
WHERE DATETIME = (
    SELECT MIN(DATETIME)
    FROM ANIMAL_INS
)

--동물 보호소에 동물이 몇 마리 들어왔는지 조회하는 SQL 문을 작성해주세요.
SELECT COUNT(*) AS COUNT
FROM ANIMAL_INS

--동물 보호소에 들어온 동물의 이름은 몇 개인지 조회하는 SQL 문을 작성해주세요. 이때 이름이 NULL인 경우는 집계하지 않으며 중복되는 이름은 하나로 칩니다.
SELECT COUNT(*) AS COUNT
FROM (
    SELECT DISTINCT NAME
    FROM ANIMAL_INS
    WHERE NAME IS NOT NULL
) AS unique_names;

--2022년 1월의 도서 판매 데이터를 기준으로 저자 별, 카테고리 별 매출액(TOTAL_SALES = 판매량 * 판매가) 을 구하여, 저자 ID(AUTHOR_ID), 저자명(AUTHOR_NAME), 카테고리(CATEGORY), 매출액(SALES) 리스트를 출력하는 SQL문을 작성해주세요.
--결과는 저자 ID를 오름차순으로, 저자 ID가 같다면 카테고리를 내림차순 정렬해주세요.
--날짜는 저렇게 범위로 가자 !
SELECT ts.AUTHOR_ID, at.AUTHOR_NAME, ts.CATEGORY, ts.TOTAL_SALES
FROM (
    SELECT b.AUTHOR_ID, b.CATEGORY, SUM(b.PRICE * s.SALES) AS TOTAL_SALES
    FROM BOOK b
    JOIN BOOK_SALES s ON b.BOOK_ID = s.BOOK_ID
    WHERE s.SALES_DATE >= '2022-01-01' AND s.SALES_DATE < '2022-02-01'
    GROUP BY b.AUTHOR_ID, b.CATEGORY
) AS ts
JOIN AUTHOR at ON at.AUTHOR_ID = ts.AUTHOR_ID
ORDER BY ts.AUTHOR_ID ASC, ts.CATEGORY DESC;