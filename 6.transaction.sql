-- author 테이블에 post_count 라고 컬럼(int) 추가
ALTER TABLE ahthor add column post_count int;
ALTER TABLE ahthor modify column post_count int default 0;

-- post에 글 쓴 후에, author 테이블에 post_count 값에 + 1 => 트랜잭션
start transaction; -- 두 쿼리를 묶겠다
update author set post_count = post_count + 1 where id = 1; -- success
insert into post(title, author_id) values ('hello world java', 3); -- 실패, 에러나는 쪽에서 stop이 된다.그러면 update만 임시 저장되어 있는 상태로 남는다
-- 위 쿼리들이 정상실행됐으면 x, 실패했으면 y -> 분기처리 procedure
commit;
-- 또는
rollback;

-- stored 프로시저를 활용한 트랜잭션 테스트
DELIMITER //
CREATE PROCEDURE InsertPostAndUpdateAuthor()
BEGIN
    DECLARE exit handler for SQLEXCEPTION -- SQL EXCEPTION(예외)가 터지면 ROLLBACK 하겠다.
    BEGIN
        ROLLBACK;
    END;
    -- 트랜잭션 시작
    START TRANSACTION;
    -- UPDATE 구문
    UPDATE author SET post_count = post_count + 1 where id = 1;
    -- INSERT 구문
    insert into post(title, author_id) values('hello world java', 3);
    -- 모든 작업이 성공했을 때 커밋
    COMMIT;
END //
DELIMITER ;
-- 프로시저 호출
CALL InsertPostAndUpdateAuthor();