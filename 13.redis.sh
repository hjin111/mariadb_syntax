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

# 캐싱 기능 구현
# 1번 author 회원 정보 조회
# select name, email, age from author where id=1;
# 위 데이터의 결과값을 redis로 캐싱 : json 데이터 형식으로 저장
set user:1:detail "{\"name\":\"hong\", \"email\":\"hong@naver.com\", \"age\":30}" ex 10

# list
# redis의 list는 java의 deque와 같은 구조 즉, double-ended queue 구조

# 데이터 왼쪽 삽입
LPUSH key value
# 데이터 오른쪽 삽입
RPUSH key value
# 데이터 왼쪽부터 꺼내기
LPOP key
# 데이터 오른쪽부터 꺼내기
RPOP key

lpush hongildongs hong1
lpush hongildongs hong2
lpush hongildongs hong3

lpop hongildongs

# 꺼내서 없애는게 아니라, 보기만
lrange hongildongs -1 -1
lrange hongildongs 0 0

# 데이터 개수 조회
llen key
llen hongildongs
# list의 요소 조회시에는 범위지정
lrange hongildongs 0 -1 # 처음부터 끝까지
# start 부터 end까지 조회
lrange hongildongs start end
# ttl 적용
expire hongildongs 20
# ttl 조회
ttl hongildongs

# 어떤 목적으로 사용될 수 있을까?
# 최근 본 상품목록, 최근 방문한 페이지
rpush 사과
rpush 배
rpush 사과
rpop
rpop
rpop

# pop과 push 동시
RPOPLPUSH A리스트 B리스트 # A리스트에서 RPOP를 해서 B리스트에 LPUSH 한다.

# 최근 방문한 페이지 
# 5개 정도 데이터 push
# 최근방문한 페이지 3개 정도만 보여주기
rpush mypages www.google.com
rpush mypages www.naver.com
rpush mypages www.google.com
rpush mypages www.daum.com
rpush mypages www.naver.com
lrange mypages 2 -1

# 위 방문페이지를 5개에서 뒤로가기 앞으로가기 구현
# 뒤로가기 페이지를 누르면 뒤로가기 페이지가 뭔지 출력
# 다시 앞으로 가기 누르면 앞으로간 페이지가 뭔지 출력
rpush forwards www.google.com
rpush forwards www.naver.com
rpush forwards www.yahoo.com
rpush forwards www.daum.com
lrange forwards -1 -1 
rpoplpush forwards backwards # lpoprpush가 없어서 구현 하기 어려움

# set 자료구조
# set자료구조에 멤버추가
sadd members member1
sadd members member2
sadd members member1

# set 조회
smembers members

# set에서 멤버 삭제
srem members member2
# set멤버 개수 반환
scard members
# 특정 멤버가 set안에 있는지 존재 여부 확인
sismember members member3

# 매일 방문자수 계산
sadd visit:2024-05-27 hong1@naver.com
sadd visit:2024-05-25 hong2@naver.com
sadd visit:2024-05-26 hong3@naver.com

# zset(sorted set)
zadd zmembers 3 member1
zadd zmembers 4 member2
zadd zmembers 1 member3
zadd zmembers 2 member4

# score 기준 오름차순 정렬
zrange zmembers 0 -1
# score 기준 내림차순 정렬
zrevrange zmembers 0 -1

# zset 삭제
zrem zmembers member2
# zrank는 해당 멤버가 index 몇번째인지 출력
zrank zmembers member2

# 최근 본 상품목록 => sorted set (zset) 을 활용하는 것이 적절
zadd recent:products 192411 apple
zadd recent:products 192413 apple
zadd recent:products 192415 banana
zadd recent:products 192417 orange
zadd recent:products 192425 apple
zadd recent:products 192430 apple
zrevrange recent:products 0 2

# hashes
# 해당 자료구조에서는 문자, 숫자가 구분
hset product:1 name "apple" price 1000 stock 50
hget product:1 price
# 모든 객체 값 get
hgetall product:1
# 특정 요소 값 수정
hset product:1 stock 40

# 특정 요소의 값을 증가/감소
hincrby product:1 stock 5
hget product:1 stock
hincrby product:1 stock -5
