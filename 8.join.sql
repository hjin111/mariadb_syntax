-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기.
select * from author inner join post on author.id=post.author_id;
select * from author a inner join post p on a.id = p.author_id;
-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
select p.id, p.title, p.contents , a.email from post p  
inner join author a on p.author_id = a.id; -- 익명 글은 다 날라감

-- 모든 글 목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력
select p.id, p.title, p.contents, a.email from post p 
left outer join author a on p.author_id = a.id;

-- join 된 상황에서 where 조건 : on 뒤에 where 조건이 나옴.
-- 1) 글쓴이가 있는 글 중에 글의 title과 저자의 이메일을 출력해달라, 저자의 나이는 25세 이상만 뽑아라
select p.title, a.email from post p inner join author a on p.author_id = a.id where a.age >= 25;
-- 2) 모든 글 목록 중에 글의 title과 저자가 있다면 email을 출력, 올해 2024-05-01 이후에 만들어진 글만 출력하시오.
select p.title, ifnull(a.email,'익명') from post p left outer join author a on a.id = p.author_id where p.title is not null and p.created_time >= '2024-05-01';

-- 조건에 맞는 도서와 저자 리스트 출력
SELECT B.BOOK_ID, A.AUTHOR_NAME, DATE_FORMAT(B.PUBLISHED_DATE,'%Y-%m-%d') AS PUBLISHED_DATE 
FROM BOOK B INNER JOIN AUTHOR A ON B.AUTHOR_ID = A.AUTHOR_ID 
WHERE B.CATEGORY = '경제'
ORDER BY B.PUBLISHED_DATE;

-- union : 중복제외한 두 테이블의 select을 결합
-- 컬럼의 개수와 타입이 같아야함에 유의
-- union all : 중복 포함
select 컬럼1, 컬럼2 from table1 union select 컬럼1, 컬럼2 from table2;
-- author 테이블의 name, email 그리고 post 테이블의 title, contents union
select  name, email from author union select title, contents from post;


-- 서브쿼리 : select문 안에 또다른 select문을 서브쿼리라 한다.
-- select절 안에 서브쿼리
-- author email과 해당 author가 쓴 글의 개수를 출력
select email, (select count(*) from post p where p.author_id = a.id ) as count
from author a;

-- from절 안에 서브쿼리
select a.name from (select * from author) as a; -- select a.name from author as a; 이거랑 똑같음

-- where절 안에 서브쿼리
select a.* from author a inner join post p on a.id = p.author_id;
select * from author where id in(select author_id form post); -- inner join을 서브쿼리로 대체 가능

-- 없어진 기록 찾기 문제 : join으로 풀수 있는 문제, 서브쿼리로도 풀어보기
-- join
SELECT OUTS.ANIMAL_ID, OUTS.NAME
FROM ANIMAL_OUTS OUTS LEFT JOIN ANIMAL_INS INS ON OUTS.ANIMAL_ID = INS.ANIMAL_ID
WHERE INS.ANIMAL_ID IS NULL 
ORDER BY OUTS.ANIMAL_ID;
-- 서브쿼리
SELECT OUTS.ANIMAL_ID, OUTS.NAME
FROM ANIMAL_OUTS OUTS
WHERE ANIMAL_ID NOT IN(SELECT ANIMAL_ID FROM ANIMAL_INS) ORDER BY OUTS.ANIMAL_ID;

-- 집계함수
SELECT COUNT(*) FROM author; -- count(*) 와 count(id)는 같다.
select sum(price) from post;
select round(avg(price),0) from post; -- round(avg(price),0) 소수점 0번째 자리에서 반올림

-- group by와 집계함수
select author_id from post group by author_id;
select author_id, count(*) from post group by author_id;
select author_id, count(*), sum(price), round(avg(price),0), min(price), max(price) from post group by author_id;

-- 저자, email, 해당 저자가 작성한 글 수를 출력
-- inner join은 글 안쓴 사람이 완전 배제가 되니깐 left join 으로 하기
select a.id, if(p.id is null, 0, count(*) ) from author a left join post p on a.id = p.author_id group by a.id; 

-- where와 group by ( group by 앞에 where )
-- 연도별 post 글 출력, 연도가 null인 데이터는 제외 
select DATE_FORMAT( created_time, '%Y') AS 연도 , count(*) 
from post 
where created_time is not null 
group by DATE_FORMAT( created_time, '%Y');

select DATE_FORMAT( created_time, '%Y') AS year , count(*) 
from post 
where created_time is not null 
group by year; -- select 에서 쓴 별칭을 group by에서 쓸 수 있음

-- 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기
SELECT CAR_TYPE, COUNT(*) AS CARS 
FROM CAR_RENTAL_COMPANY_CAR 
WHERE OPTIONS LIKE '%통풍시트%' OR OPTIONS LIKE '%열선시트%' OR OPTIONS LIKE '%가죽시트%'
GROUP BY CAR_TYPE
ORDER BY CAR_TYPE;

-- 입양 시각 구하기(1)
SELECT cast(DATE_FORMAT(DATETIME, '%H') as unsigned ) as HOUR, COUNT(*) AS COUNT 
FROM ANIMAL_OUTS 
WHERE DATE_FORMAT(DATETIME, '%H:%i' ) between '09:00' and '19:59'
GROUP BY HOUR
ORDER BY HOUR;

-- HAVING : group by를 통해 나온 통계에 대한 조건3
select author_id, count(*) as count from post group by author_id;
-- 글을 2개이상 쓴사람에 대한 통계정보
select author_id, count(*) as count from post where id>2
group by author_id HAVING count >= 2;
-- (실습) 포스팅 price가 2000원 이상인 글을 대상으로, 
-- 작성자별로 몇건인지와 평균 price를 구하되, 
-- 평균 price가 3000원 이상인 데이터를 대상으로만 통계 출력
select author_id, avg(price) as avg_price from post 
where price >= 2000
group by author_id
having avg_price >= 3000;

-- 동명 동물 수 찾기
SELECT NAME, COUNT(*) AS COUNT 
FROM ANIMAL_INS 
WHERE NAME IS NOT NULL
GROUP BY NAME HAVING COUNT >= 2
ORDER BY NAME;

-- (실습)2건 이상의 글을 쓴 사람의 email, 글의수 구할건데
-- 나이는 25세 이상인 사람만 통계에 사용하고, 가장 나이 많은 사람 1명의 통계만 출력하시오.
select a.id, count(a.id) as count from author a 
inner join post p on a.id = p.author_id
where a.age >= 25
group by a.id having count >= 2 order by max(a.age) desc limit 1; -- GROUP BY 하고나서 내부적으로 AGE 값을 갖고 있음

-- 다중열 group by
select author_id, title, count(*) from post group by author_id, title;

-- 재구매가 일어난 상품과 회원 리스트 구하기.
SELECT USER_ID, PRODUCT_ID
FROM ONLINE_SALE 
GROUP BY USER_ID, PRODUCT_ID HAVING COUNT(*) >= 2
ORDER BY USER_ID , PRODUCT_ID DESC;