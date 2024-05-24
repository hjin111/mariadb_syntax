sudo apt-get update 
sudo apt-get install redis-server
redis-server --version 

# redis 접속 
# cli : commandline interface 프로그램 상호작용할 수 있는 툴이다.
redis-cli

# redis는 0번~15번까지의 database 구성
# 데이터베이스 선택
select 번호(0번디폴트)

# 데이터베이스내 모든 키 조회
keys * 

# 일반 string 자료구조
# key:value 값 세팅
# key 값은 중복되면 안됨
SET key(키)value(값)
set test_key1 test_value1
set user:email:1 hongildong@naver.com
# set할 때 key값이 이미 존재하면 덮어쓰기 되는것이 기본
# 맵저장소에서 key 값은 유일하게 관리가 됨으로
# nx : not exist
set user:email:1 hongildong2@naver.com # 덮어씌어지기 됨
set user:email:1 hongildong2@naver.com nx # nx 있으면 없을 때만 set 하겠다 / 있을 때는 set 안함
# ex(만료시간-초단위) - ttl(time to live)
set user:email:2 hong2@naver.com ex 20

# get을 통해 value값 얻기
get test_key1

# 특정 key 삭제
del user:email:1
# 현재 데이터베이스 모든 key값 삭제
flushdb

# 좋아요 기능 구현 
select likes from posting where email = "honaldo" for update; # locking을 걸어야 함
update posting set likes = likes + 1 where ...; 
# rdb -> 동시성이슈 -> lock -> 성능떨어짐 -> redis 써야함
# 싱글스레드(동시성이슈피해감) && 인메모리기반(성능우수)
set likes:posting:1 0
incr likes:posting:1 # 특정 key 값의 value를 1만큼 증가
decr likes:posting:1 # 1 줄어듬
get likes:posting:1

# 재고 기능 구현
set product:1:stock 100
decr product:1:stock
get product:1:stock

# bash쉘을 활용하여 재고감소 프로그램 작성






