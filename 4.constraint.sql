-- not null 조건 추가
alter table 테이블명 modify column 컬럼명 타입 not null;

-- auto_increment
alter table author modify column id bigint auto_increment;
alter table post modify column id bigint auto_increment;

-- 1. post에서 author.id에 제약조건을 가지고 있다보니, author.id에 새로운 제약조건을 추가하는 부분에서 문제 발생
-- author.id에 제약조건 추가시 fk로 인해 문제 발생시
-- fk 먼저 제거 이후에 author.id에 제약조건 추가.
select * from information_schema.key_column_usage where table_name = 'post';
-- 삭제
alter table post drop foreign key post_ibfk_1;
-- 삭제된 제약조건 다시 추가
alter table post add constraint post_author_fk
foreign key(author_id) references author(id);

-- uuid
alter table post add column user_id char(36) default (UUID()); -- pk 값으로 써도 됨

-- unique 제약조건
alter table author modify column email VARCHAR(255) unique;

-- on delete cascade 테스트 -> 부모테이블의 id를 수정하면?? 자식테이블 수정안됨 , 부모테이블 삭제하면 자식테이블도 삭제됨
-- 제약조건 조회
select * from information_schema.key_column_usage where table_name = 'post';
-- 제약조건 삭제
alter table post drop foreign key post_author_fk;
-- 제약조건 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade;

-- on update cascade 테스트
-- 제약조건 (삭제후) 추가
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade on update cascade;

-- (실습) delete는 set null, updagte cascade 
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete set null on update cascade;