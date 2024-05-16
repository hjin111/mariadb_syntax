-- 데이터베이스 접속 (터미널)
mariadb -u root -p

-- 스키마(database) 목록 조회
show databases; -- 시스템 데이터베이스가 나온다.

-- board 데이터베이스(스키마) 생성 / mysql에서는 데이터베이스=스키마  
CREATE DATABASE board;