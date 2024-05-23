-- 사용자관리
-- 사용자 목록 조회
select * from mysql.user;

-- 사용자 생성
-- %는 원격 포함한 anywhere 접속
create user 'test1'@'localhost' identified by '4321';

-- 터미널에서 테스트1 계정 로그인 할 때 
mariadb -u test1 -p

-- 사용자에게 select 권한 부여 ( 특정 계정에 특정 권한을 줌 ) , update 권한 주고 싶으면 grant update on board.author to 'test1'@'localhost';
grant select on board.author to 'test1'@'localhost';
-- 사용자 권한 회수
revoke select on board.author from 'test1'@'localhost';
-- 환경설정을 변경후 확정
flush privileges;
-- 권한 조회
show grants for 'test1'@'localhost';
-- test1으로 로그인 후에 
select * from board.author;
-- 사용자 계정 삭제
drop user 'test1'@'localhost';

-- view
-- view 생성
create view author_for_marketing_team as 
select name, age, role from author;

-- view 조회
select * from author_for_marketing_team;

-- test계정에 view select 권한 부여
grant select on board.author_for_marketing_team TO 'test1'@'localhost';
flush privileges; -- 이것까지 해주기

-- view 변경(대체)
create or replace view author_for_marketing_team as select name, email, age, role from author;

-- view 삭제
drop view author_for_marketing_team;

-- 프로시저 생성
DELIMITER //
CREATE PROCEDURE test_procedure() -- 프로시저명
BEGIN
    select 'hello world';
END
// DELIMITER ; -- 세미콜론 띄어쓰기 꼭 해주기

-- 프로시저 호출
call test_procedure();

-- 프로시저 삭제
drop procedure test_procedure;

-- 게시글 목록 조회 프로시저 생성
DELIMITER //
CREATE PROCEDURE 게시글목록조회() 
BEGIN
    select * from post;
END
// DELIMITER ; 

call 게시글목록조회();

-- 게시글 단건 조회
DELIMITER //
CREATE PROCEDURE 게시글단건조회(in 저자id int, in 제목 varchar(255)) -- 저자id랑 제목 : 매개변수
BEGIN
    select * from post where author_id = 저자id and title = 제목;
END
// DELIMITER ; 

call 게시글단건조회(5, 'world');

-- 글쓰기 : title, contents, 저자ID
DELIMITER //
CREATE PROCEDURE 글쓰기(in titleInput varchar(255), in contentsInput varchar(255), in authorId int)
BEGIN
    insert into post(title, contents, author_id) values (titleInput, contentsInput, authorId);
END
// DELIMITER ; 

call 글쓰기('안녕', '하위', 6);

-- 글쓰기 : title, contents, email
DELIMITER //
CREATE PROCEDURE 글쓰기2(in titleInput varchar(255), in contentsInput varchar(255), in emailInput varchar(255))
BEGIN
    declare authorId int; -- 변수선언
    select id into authorId from author where email = emailInput;
    insert into post(title, contents, author_id) values (titleInput, contentsInput, authorId);
END
// DELIMITER ; 
call 글쓰기2('안녕', '하위', 'hello@naver.com');

-- sql에서 문자열 합치는 CONCAT('hello','world');
-- 글상세조회 : input 값이 postId
-- title, contents, '홍길동' + '님'
-- 조인문
DELIMITER //
CREATE PROCEDURE 글상세조회(in postId int)
BEGIN
    select p.title, p.contents , CONCAT( a.name, '님') from post p inner join author a on p.author_id = a.id where p.id  = postId;
END
// DELIMITER ; 

-- 서브쿼리
DELIMITER //
CREATE PROCEDURE 글상세조회(in postId int)
BEGIN
    declare authorName varchar(255);
    select name into authorName from author where id = (select author_id from post where id = postId );
    set authorName = concat(authorName, '님');
    select title, contents, authorName from post where id = postId;
END
// DELIMITER ; 

-- 등급조회 ( IF문 )
-- 글을 100개 이상 쓴 사용자는 고수입니다. 출력
-- 10개 이상 100개 미만이면 중수입니다.
-- 그외는 초보입니다.
-- input값 : email값
DELIMITER //
CREATE PROCEDURE 등급조회(in emailInput varchar(255))
BEGIN
    declare authorId varchar(255);
    declare count int;
    select id into authorId from author where email = emailInput;
    select count(*) into count from post where author_id = authorId;
    IF count >= 100 then
        select '고수입니다.';
    ELSEIF count>=10 and count<100 then
        select '중수입니다.';
    ELSE 
        select '초보입니다.';
    END IF;
END
// DELIMITER ; 

-- 반복을 통해 post 대량 생성
-- 사용자가 입력한 반복 횟수에 따라 글이 도배되는데, title문은 '안녕하세요' 
DELIMITER //
CREATE PROCEDURE 글도배(in count int)
BEGIN
    declare countValue int default 0; -- default 0 해서 기본값을 0으로 지정
    WHILE countvalue < count DO
        insert into post(title) values('안녕하세요');
        set countvalue = countValue + 1;
    END WHILE;
END
// DELIMITER ; 

-- 프로시저 생성문 조회
show create procedure 프로시저명;

-- 프로시저 권한 부여
grant excute on board.글도배 to 'test1'@'localhost';