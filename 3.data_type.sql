-- tinyint는 -128~127까지 표현
-- author 테이블에 age 컬럼 추가.
ALTER TABLE author add column age tinyint;

-- insert시에 age : 200 -> 125
insert into author(id, email, age) values (5, 'hello@naver.com', 130);
insert into author(id, email, age) values (6, 'hello6@naver.com', 125);
-- unsigned시에 255까지 표현범위 확대
alter table author modify column age tinyint unsigned; -- unsingned;
insert into author(id, email, age) values (7, 'hello@naver.com', 200);

-- decimal 실습
ALTER TABLE post add column price decimal(10,3);-- 총 자릿수 10자리, 소수부 3자리
describe post;

-- decimal 소수점 초과 값 입력 후 짤림 확인
insert into post(id, title, price) values (7, 'hello java', 3.123123123);
-- update : price를 1234.1
update post set price = 1234.1 where id = 7;

-- blob 바이너리데이터 실습
-- author 테이블에 profile_image 컬럼을 blob 형식으로 추가
ALTER TABLE author add column profile_image blob;
describe author;
ALTER TABLE author modify column profile_image longblob;
insert into author(id, email, profile_image) values (8, 'abc@naver.com', LOAD_FILE('C:\\test_image.jpeg'));

-- enum : 삽입될 수 있는 데이터 종류를 한정하는 데이터 타입
-- role 컬럼 추가
alter table author add column role enum('admin', 'user') not null default 'user';
-- enum 컬럼 실습
-- user1을 insert => 에러 ( 정해진 대상 값이 아니라 다른 값이 들어오면 에러가 남 )
insert into author(id, email, role) values(9, 'abc@naver.com', 'user1');
-- user 또는 admin  insert => 정상
insert into author(id, email, role) values(9, 'abc@naver.com', 'user');

-- date 타입
-- author 테이블에 birth_day 컬럼을 date로 추가
-- 날짜 타입의 insert는 문자열 형식으로 insert (-같은거 붙여줘야 함 2000-04)
ALTER TABLE author add column birth_day DATE;
insert into author(id, email, birth_day) values (13, 'hello@naver.com', '1999-05-01');

-- datetime 타입
-- author, post 둘다 datetime으로 created_time 컬럼추가
-- DATETIME DEFAULT CURRENT_TIMESTAMP 옵션 많이 사용 ( 현재시간을 default로 삽입하는 형식 )
ALTER TABLE author add column created_time datetime;
insert into author(id, email, created_time) values(14, 'hello14@naver.com', '2024-05-17 12:22:56');
ALTER TABLE author modify column created_time datetime default current_timestamp;
insert into author(id, email) values(15, 'hello15@naver.com');
ALTER TABLE post add column created_time datetime;
insert into post(id, title, created_time) values(8, 'hello', '1999-05-17 12:22:56');
ALTER TABLE post modify column created_time datetime default current_timestamp;
insert into post(id, title) values(9, 'hello9');

-- 비교연산자
-- and 또는 && 
select * from post where id >= 2 and id <= 4;
select * from post where id between 2 and 4;
-- or 또는 ||
-- NOT 또는 !
select * from post where not(id < 2 or id > 4);
select * from post where !(id < 2 or id > 4);
-- NULL인지 아닌지
select * from post where contents is null;
select * from post where contents is not null;
-- in(리스트형태), not in(리스트형태)
select * from post where id in(1,2,3,4);
select * from post where id not in(1,2,3,4);

-- like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select * from post where title like '%o'; -- o로 끝나는 title 검색
select * from post where title like 'h%'; -- h로 시작하는 title 검색
select * from post where title like '%llo%'; -- 단어의 중간에 llo라는 키워드가 있는 경우 검색
select * from post where title not like '%o'; -- o로 끝나는 title이 아닌 title검색

-- ifnull(a,b) : 만약에 a가 null이면 b반환, null이 아니면 a반환
select title, contents, ifnull(author_id, '익명') as writer from post;
-- 경기도에 위치한 식품창고 목록 출력하기 (프로그래머스 문제)
SELECT WAREHOUSE_ID, WAREHOUSE_NAME, ADDRESS, IFNULL(FREEZER_YN, 'N') AS FREEZER_YN
FROM FOOD_WAREHOUSE 
WHERE ADDRESS LIKE '경기도%'
ORDER BY WAREHOUSE_ID;

-- REGEXP : 정규표현식을 활용한 조회
SELECT * FROM author where name REGEXP '[a-z]'; -- name에 a 부터 z 까지 이루어져 있는걸 찾아라 
SELECT * FROM author where name REGEXP '[가-힣]'; -- 한글로 된 이름을 찾아라

-- 날짜 변환 : 숫자 -> 날짜, 문자 -> 날짜 변환
-- CAST와 CONVERT
SELECT CAST(20200101 AS DATE);
SELECT CAST('20200101' AS DATE);
SELECT CONVERT(20200101 ,DATE);
SELECT CONVERT('20200101' ,DATE);

-- datetime 조회방법
select * from post where created_time like '2024-05%';
select * from post where created_time <= '2024-12-31' and created_time>='1999-01-01';
select * from post where created_time between '2024-12-31' and '1999-01-01';

-- date_format
select date_format(created_time, '%Y-%m') from post;
-- (실습) post를 조회할때 date_format 활용하여 2024년 데이터 조회, 결과는 *
select * from post where date_format(created_time, '%Y') = '2024';

-- 오늘날짜
select now();

-- 흉부외과
SELECT DR_NAME, DR_ID, MCDP_CD, DATE_FORMAT(HIRE_YMD,'%Y-%m-%d') AS HIRE_YMD
FROM DOCTOR
WHERE MCDP_CD IN ('CS', 'GS')
ORDER BY HIRE_YMD DESC, DR_NAME ASC;








