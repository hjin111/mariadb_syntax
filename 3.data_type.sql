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
