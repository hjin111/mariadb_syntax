-- 흐름제어 : case문
SELECT 컬럼1, 컬럼2, 컬럼3
CASE 컬럼4
    WHEN [비교값1] THEN 결과값1
    WHEN [비교값2] THEN 결과값2
    ELSE 결과값3
END
FROM 테이블명;

-- post 테이블에서 1번 user는 first author, 2번 user는 second author 출력
SELECT id, title, contents,
    CASE author_id
        WHEN 1 THEN 'first author'
        WHEN 2 THEN 'second author'
        ELSE 'others'
    END as author_id
FROM post;

-- author_id가 있으면 그대로 출력 else author_id, 
-- 없으면 '익명사용자'로 출력되도록 post테이블 조회
SELECT id, title, contents
    CASE 
        WHEN author_id IS NULL THEN '익명사용자'
        ELSE author_id
    END as author_id
FROM post;

-- 위 case문을 ifnull 구문으로 변환
SELECT id, title, contents,
    IFNULL(author_id, '익명사용자') as author_id
FROM post;

-- if문 구문으로 변환
SELECT id, title, contents,
    IF(author_id IS NULL, '익명사용자', author_id) as author_id
FROM post;

-- (실습) 조건에 부합하는 중고거래 상태 조회하기
SELECT BOARD_ID, WRITER_ID, TITLE, PRICE,
    CASE STATUS
    WHEN 'SALE' THEN '판매중'
    WHEN 'RESERVED' THEN '예약중'
    WHEN 'DONE' THEN '거래완료'
    END AS STATUS
FROM USED_GOODS_BOARD
WHERE CREATED_DATE = '2022-10-05'
ORDER BY BOARD_ID DESC;

SELECT BOARD_ID, WRITER_ID, TITLE, PRICE,
    CASE 
    WHEN STATUS = 'SALE' THEN '판매중'
    WHEN STATUS = 'RESERVED' THEN '예약중'
    WHEN STATUS = 'DONE' THEN '거래완료'
    END AS STATUS
FROM USED_GOODS_BOARD
WHERE CREATED_DATE = '2022-10-05'
ORDER BY BOARD_ID DESC;

-- (실습) 12세 이하인 여자 환자 목록 출력하기
SELECT PT_NAME, PT_NO, GEND_CD, AGE, 
    IF(TLNO IS NULL, 'NONE', TLNO)
FROM PATIENT
WHERE AGE <= 12 AND GEND_CD = 'W'
ORDER BY AGE DESC, PT_NAME ASC;

SELECT PT_NAME, PT_NO, GEND_CD, AGE, 
    IFNULL(TLNO, 'NONE')
FROM PATIENT
WHERE AGE <= 12 AND GEND_CD = 'W'
ORDER BY AGE DESC, PT_NAME ASC;
