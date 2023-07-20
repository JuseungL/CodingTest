--특정 필드에 특정 단어 들어간 Row추출 및 오름차순 정렬
SELECT FACTORY_ID, FACTORY_NAME, ADDRESS 
FROM FOOD_FACTORY 
WHERE ADDRESS LIKE "강원도%"
ORDER BY FACTORY_ID ASC;

--DOCTOR 테이블에서 진료과가 흉부외과(CS)이거나 일반외과(GS)인 의사의 이름, 의사ID, 진료과, 고용일자를 조회하는 SQL문을 작성해주세요. 이때 결과는 고용일자를 기준으로 내림차순 정렬하고, 고용일자가 같다면 이름을 기준으로 오름차순 정렬해주세요.
SELECT DR_NAME, DR_ID, MCDP_CD, DATE_FORMAT(HIRE_YMD, '%Y-%m-%d') AS HIRE_YMD
FROM DOCTOR
WHERE MCDP_CD IN ('CS', 'GS')
ORDER BY HIRE_YMD DESC, DR_NAME ASC;

--MEMBER_PROFILE 테이블에서 생일이 3월인 여성 회원의 ID, 이름, 성별, 생년월일을 조회하는 SQL문을 작성해주세요. 이때 전화번호가 NULL인 경우는 출력대상에서 제외시켜 주시고, 결과는 회원ID를 기준으로 오름차순 정렬해주세요.
SELECT MEMBER_ID,	MEMBER_NAME,	GENDER,	DATE_FORMAT(DATE_OF_BIRTH, '%Y-%m-%d')
FROM MEMBER_PROFILE
WHERE GENDER = 'W'
  AND MONTH(DATE_OF_BIRTH) = 3
  AND TLNO IS NOT NULL
ORDER BY MEMBER_ID;

--REST_INFO와 REST_REVIEW 테이블에서 서울에 위치한 식당들의 식당 ID, 식당 이름, 음식 종류, 즐겨찾기수, 주소, 리뷰 평균 점수를 조회하는 SQL문을 작성해주세요. 이때 리뷰 평균점수는 소수점 세 번째 자리에서 반올림 해주시고 결과는 평균점수를 기준으로 내림차순 정렬해주시고, 평균점수가 같다면 즐겨찾기수를 기준으로 내림차순 정렬해주세요.
--GROUP BY: 일반적으로 COUNT, SUM, AVG, MIN, MAX 등과 같은 집계 함수와 함께 사용되어 개별 행이 아닌 행 그룹에 대한 계산을 수행
SELECT r1.REST_ID,	r1.REST_NAME,	r1.FOOD_TYPE, r1.FAVORITES,	r1.ADDRESS,	ROUND(AVG(r2.REVIEW_SCORE), 2) AS SCORE
FROM REST_INFO r1
JOIN REST_REVIEW r2 ON r1.REST_ID = r2.REST_ID
WHERE r1.ADDRESS LIKE "서울%" 
GROUP BY r1.REST_ID,	r1.REST_NAME,	r1.FOOD_TYPE, r1.FAVORITES,	r1.ADDRESS
ORDER BY SCORE DESC, r1.FAVORITES DESC;

--BOOK 테이블에서 2021년에 출판된 '인문' 카테고리에 속하는 도서 리스트를 찾아서 도서 ID(BOOK_ID), 출판일 (PUBLISHED_DATE)을 출력하는 SQL문을 작성해주세요.결과는 출판일을 기준으로 오름차순 정렬해주세요
SELECT BOOK_ID, DATE_FORMAT(PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE
FROM BOOK
WHERE YEAR(PUBLISHED_DATE) = 2021 
  AND CATEGORY ='인문'
ORDER BY PUBLISHED_DATE ASC;

--상반기 아이스크림 총주문량이 3,000보다 높으면서 아이스크림의 주 성분이 과일인 아이스크림의 맛을 총주문량이 큰 순서대로 조회하는 SQL 문을 작성해주세요.
--'%fruit%'이런거 쓸 때는 = 이 아니라 LIKE!!!!
SELECT f.FLAVOR
FROM FIRST_HALF f
JOIN ICECREAM_INFO i ON f.FLAVOR = i.FLAVOR
WHERE f.TOTAL_ORDER > 3000
  AND i.INGREDIENT_TYPE LIKE 'fruit%'
ORDER BY f.TOTAL_ORDER DESC;

--PATIENT 테이블에서 12세 이하인 여자환자의 환자이름, 환자번호, 성별코드, 나이, 전화번호를 조회하는 SQL문을 작성해주세요. 이때 전화번호가 없는 경우, 'NONE'으로 출력시켜 주시고 결과는 나이를 기준으로 내림차순 정렬하고, 나이 같다면 환자이름을 기준으로 오름차순 정렬해주세요
--COALESCE(TLNO, "NONE")에서와 같이 TLNO필드 값이 null일 때 두번째 인자로 반환하도록 하는 함수
SELECT PT_NAME, PT_NO, GEND_CD, AGE, COALESCE(TLNO, 'NONE') AS TLNO
FROM PATIENT
WHERE AGE <= 12
  AND GEND_CD = 'W'
ORDER BY AGE DESC, PT_NAME ASC;

--USED_GOODS_BOARD와 USED_GOODS_REPLY 테이블에서 2022년 10월에 작성된 게시글 제목, 게시글 ID, 댓글 ID, 댓글 작성자 ID, 댓글 내용, 댓글 작성일을 조회하는 SQL문을 작성해주세요. 결과는 댓글 작성일을 기준으로 오름차순 정렬해주시고, 댓글 작성일이 같다면 게시글 제목을 기준으로 오름차순 정렬해주세요.
SELECT b.TITLE, b.BOARD_ID, r.REPLY_ID, r.WRITER_ID, r.CONTENTS, DATE_FORMAT(r.CREATED_DATE, '%Y-%m-%d') AS CREATED_DATE
FROM USED_GOODS_BOARD b
JOIN USED_GOODS_REPLY r ON b.BOARD_ID = r.BOARD_ID
WHERE YEAR(b.CREATED_DATE) = 2022
  AND MONTH(b.CREATED_DATE) = 10
ORDER BY r.CREATED_DATE ASC, b. TITLE ASC;

--CAR_RENTAL_COMPANY_CAR 테이블에서 자동차 종류가 'SUV'인 자동차들의 평균 일일 대여 요금을 출력하는 SQL문을 작성해주세요. 이때 평균 일일 대여 요금은 소수 첫 번째 자리에서 반올림하고, 컬럼명은 AVERAGE_FEE 로 지정해주세요.
--평균 요금 계산하는 문제이더라도 무조건 GROUP BY를 쓰는 것이 아니다
SELECT ROUND(AVG(DAILY_FEE),0) AS AVERAGE_FEE
FROM CAR_RENTAL_COMPANY_CAR
WHERE CAR_TYPE = 'SUV';

--상반기에 판매된 아이스크림의 맛을 총주문량을 기준으로 내림차순 정렬하고 총주문량이 같다면 출하 번호를 기준으로 오름차순 정렬하여 조회하는 SQL 문을 작성해주세요.
SELECT FLAVOR
FROM FIRST_HALF
ORDER BY TOTAL_ORDER DESC, SHIPMENT_ID ASC;


--동물 보호소에 들어온 모든 동물의 정보를 ANIMAL_ID순으로 조회하는 SQL문을 작성해주세요. SQL을 실행하면 다음과 같이 출력되어야 합니다.
SELECT *
FROM ANIMAL_INS
ORDER BY ANIMAL_ID ASC;

--ONLINE_SALE 테이블에서 동일한 회원이 동일한 상품을 재구매한 데이터를 구하여, 재구매한 회원 ID와 재구매한 상품 ID를 출력하는 SQL문을 작성해주세요. 결과는 회원 ID를 기준으로 오름차순 정렬해주시고 회원 ID가 같다면 상품 ID를 기준으로 내림차순 정렬해주세요.
--개어렵
SELECT DISTINCT USER_ID, PRODUCT_ID
FROM ONLINE_SALE
WHERE (USER_ID, PRODUCT_ID) IN (
    SELECT USER_ID, PRODUCT_ID
    FROM ONLINE_SALE
    GROUP BY USER_ID, PRODUCT_ID
    HAVING COUNT(*) > 1
) --재구매한 유저 아이디와 제품 아이디 조합 찾음.
ORDER BY USER_ID ASC, PRODUCT_ID DESC;

--동물 보호소에 들어온 모든 동물의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 이때 결과는 ANIMAL_ID 역순으로 보여주세요. SQL을 실행하면 다음과 같이 출력되어야 합니다.
SELECT ANIMAL_ID, NAME, DATETIME
FROM ANIMAL_INS
ORDER BY NAME ASC, DATETIME DESC;

SELECT ANIMAL_ID, NAME, DATETIME
FROM ANIMAL_INS
ORDER BY NAME, DATETIME DESC;

--ONLINE_SALE 테이블과 OFFLINE_SALE 테이블에서 2022년 3월의 오프라인/온라인 상품 판매 데이터의 판매 날짜, 상품ID, 유저ID, 판매량을 출력하는 SQL문을 작성해주세요. OFFLINE_SALE 테이블의 판매 데이터의 USER_ID 값은 NULL 로 표시해주세요. 결과는 판매일을 기준으로 오름차순 정렬해주시고 판매일이 같다면 상품 ID를 기준으로 오름차순, 상품ID까지 같다면 유저 ID를 기준으로 오름차순 정렬해주세요.
SELECT DATE_FORMAT(SALES_DATE, '%Y-%m-%d'), PRODUCT_ID, USER_ID, SALES_AMOUNT
FROM (
    SELECT SALES_DATE, PRODUCT_ID, USER_ID, SALES_AMOUNT
    FROM ONLINE_SALE
    WHERE MONTH(SALES_DATE) = 3 AND YEAR(SALES_DATE) = 2022
    
    UNION ALL
    
    SELECT SALES_DATE, PRODUCT_ID, NULL AS USER_ID, SALES_AMOUNT
    FROM OFFLINE_SALE
    WHERE MONTH(SALES_DATE) = 3 AND YEAR(SALES_DATE) = 2022
) AS combined_sales
ORDER BY SALES_DATE ASC, PRODUCT_ID ASC, USER_ID ASC;


--동물 보호소에 들어온 동물 중 아픈 동물1의 아이디와 이름을 조회하는 SQL 문을 작성해주세요. 이때 결과는 아이디 순으로 조회해주세요.
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE INTAKE_CONDITION = "Sick"

--동물 보호소에 들어온 동물 중 젊은 동물1의 아이디와 이름을 조회하는 SQL 문을 작성해주세요. 이때 결과는 아이디 순으로 조회해주세요.
-- !=  이냐  NOT()이냐
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE INTAKE_CONDITION != "Aged";

SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE NOT (INTAKE_CONDITION = 'Aged');

--동물 보호소에 들어온 모든 동물의 아이디와 이름, 보호 시작일을 이름 순으로 조회하는 SQL문을 작성해주세요. 단, 이름이 같은 동물 중에서는 보호를 나중에 시작한 동물을 먼저 보여줘야 합니다.
SELECT ANIMAL_ID, NAME, DATETIME
FROM ANIMAL_INS
ORDER BY NAME ASC, DATETIME DESC;

--동물 보호소에 들어온 모든 동물의 아이디와 이름을 ANIMAL_ID순으로 조회하는 SQL문을 작성해주세요. SQL을 실행하면 다음과 같이 출력되어야 합니다.
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
ORDER BY ANIMAL_ID ASC;

--동물 보호소에서 가장 먼저 들어온 동물의 이름을 조회하는 SQL문, ASC 생략 가능
SELECT NAME
FROM ANIMAL_INS
ORDER BY DATETIME ASC
LIMIT 1;

--USER_INFO 테이블에서 2021년에 가입한 회원 중 나이가 20세 이상 29세 이하인 회원이 몇 명인지 출력하는 SQL문을 작성해주세요
SELECT COUNT(*) AS USERS
FROM USER_INFO
WHERE AGE BETWEEN 20 AND 29
  AND YEAR(JOINED) = 2021;
