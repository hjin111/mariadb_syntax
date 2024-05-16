-- 데이터베이스 접속 (터미널)
mariadb -u root -p

-- 스키마(database) 목록 조회
show databases; -- 시스템 데이터베이스가 나온다.

-- board 데이터베이스(스키마) 생성 / mysql에서는 데이터베이스=스키마  
CREATE DATABASE board;

-- 데이터베이스 선택
use board;

-- 테이블 조회
show tables;

-- author 테이블 생성 / pk는 not null과 유니크다
CREATE TABLE author(id INT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255));

-- 테이블 컬럼 조회
describe author;
-- 컬럼 상세 조회
show full columns from author;

-- 테이블 생성문 조회
show create table author;

-- posts 테이블 신규 생성(id, title, content, author_id, 테이블 차원에서의 제약 조건)
CREATE TABLE posts(id int primary key, title VARCHAR(255), content VARCHAR(255), author_id int, foreign key(author_id) references author(id));

-- test1 스키마(데이터베이스) 생성
-- test1 스키마(데이터베이스) 삭제
CREATE DATABASE test1;
DROP DATABASE test1;

-- 테이블 index 조회
show index from author;
show index from posts;

-- ALTER문 : 테이블의 구조를 변경
-- 테이블 이름 변경
alter table posts rename post;
-- 테이블 컬럼 추가
alter table author add column test1 varchar(50);
-- 테이블 컬럼 삭제
alter table author drop column test1;
-- 테이블 컬럼명 변경
alter table post change column content contents varchar(255);
-- 테이블 컬럼 타입과 제약조건 변경
alter table author modify column email varchar(255) not null; -- not null은 제약 조건

-- 실습 : ahthor테이블에 address 컬럼 추가. varchar(255)
alter table author add column address varchar(255);
-- 실습 : post 테이블에 title은 not null 제약조건 추가, contents는 3000자로 변경
alter table post modify column title varchar(255) not null;
alter table post modify column contents varchar(3000);


 CREATE TABLE `post` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
);

-- 테이블 삭제
drop table 테이블명;
