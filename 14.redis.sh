# window 에서는 기본설치 안됨 -> 도커를 통한 resdis 설치
docker run -- name redis - containmer -d -p 6379:6379 redis

# redis 접속명령어
redis-cli

# docker redis 접속명령어
docker exec -it <containerID> redis-cli

# redis는 0~15번까지의 db로 구성(default는 0번 db)
# db번호 선택
select db번호

# db내 모든 키 조회
keys *

# 가장 일반적인 Stirng 자료구조

# set을 통해 key:value 세팅
set user1 hong1@naver.com
set user:email:1 hong1@naver.com
set user:email:2 hong2@naver.com
# 기존에 key:value 존재할경우 덮어쓰기
set user:email:1 hong3@naver.com
# key값이 이미 존재하면 pass, 없으면 set : nx
set user:email:1 hong4@naver.com nx
# 만료시간(ttl) 설정(초단위) : ex
set user:email:5 hong5@naver.com ex 10
# redis 실전활용 : token 등 사용자 인증정보 저장 -> 빠른성능활용
set user:1:refresh_token rlackswls ex 1800
# key로 통해 value get
get user1
# 특정 key삭제
del user1
# 현재 db 내 모든 key값 삭제
flushdb

# redis실전활용 : 좋아요기능 구현 -> 동시성이슈 해결
set likes:posting:1 0 # redis 는 기본적으로 모든 key:value가 문자열. 내부적으로는 "0"으로 저장장
incr likes:posting:1 # 특정 key값의 value를 1만큼 증가
decr likes:posting:1 # 특정 key값의 value를 1만큼 감소

# redis실전활용 : 재고관리구현 -> 동시성이슈 해결
set stocks:product:1 100
decr stocks:product:1
incr stocks:product:1

# redis실전활용 : 캐싱기능구현
# 1번 회원 정보 조회 : select name, email, age from member where id=1;
# 위 데이터의 결과값을 spring 서버를 통해 json으로 변형하여, redis 캐싱
# 최종적이 데이터 형식 : {"name":"hong", "email":"hong@daum.net", "age":30}
set member:info:1 "{\"name\":\"hong\", \"email\":\"hong@daum.net\", \"age\":30}" ex 1000

#list 자료구조
# redis의 list는 deque와 같은 자료구조. 즉 double-ended queue구조
# lpush : 데이터를 list자료구조에 왼쪽부터 삽입
# rpush : 데이터를 list자료구조에 오른쪽부터 삽입
lpush hongs hong1
lpush hongs hong2
rpush hongs hong3
# list조회 : 0은 리스트의 시작인덱스를 의미. -1은 리스트의 마지막인덱스를 의미
lrange hongs 0 -1 #전체조회
lrange hongs -1 -1 #마지막값조회
lrange hongs 0 0 #0값조회
lrange hongs -2 -1 #끝에두개값 조회
lragne hongs 0 2 #0번째부터 2번째까지
#list값 꺼내기. 꺼내면서 삭제.
rpop hongs
lpop hongs
# A리스트에서 rpop하여 B리스트에서 lpush
rpoplpush 
# list의 데이터 개수 조회
llen hongs
# ttl 적용
expire hongs 20
# ttl조회
ttl hongs
# redis실전활용 : 최근조회한 상품목록
rpush user:1:recent:product apple
rpush user:1:recent:product banana
rpush user:1:recent:product orange
rpush user:1:recent:product melon
rpush user:1:recent:product mango
# 최근본상품3개조회
lrange user:1:recent:product -3 -1

# set자료구조 : 중복없음, 순서없음
sadd memberlist m1
sadd memberlist m2
sadd memberlist m3
# set 조회
smembers  memberlist
# set멤버 개수 조회
scard memberlist
# 특정멤버가 set안에 있는 존재여부 확인
sismember memberlist m2

# redis실전활용 : 좋아요 구현
# 게시글상세보기에 들어가면
scard posting:likes:1
sismember posting:like:1 a1@naver.com
# 게시글에 좋아요룰 하면
sadd posting:likes:1 a1@naver.com
# 좋아요한사람을 클릭하면
smembers posting:likes:1

# zset : sorted set
# zset을 활용해서 최근시간순으로 정렬가능
# zset도 set이므로 같은 상품을 add할 경우에 중복이 제거되고, score(시간간)값만 업데이트 
zadd user:1:recent:product 091330 mango
zadd user:1:recent:product 091331 apple  # apple 최근근에 들어온게 남아있고 원래있던게 삭제
zadd user:1:recent:product 091332 banana
zadd user:1:recent:product 091333 orange
zadd user:1:recent:product 091324 apple

# zset조회 : zrange(score기준오른차순), zrevrange(score기준내림차순)
zrange user:1:recent:product 0 2
zrevrange user:1:recent:product 0 2
# withscores를 통해 score 값까지 같이 출력
zrevrange user:1:recent:product 0 2 withscores

# hashes : value가 map형태의 자료구조(key:value, key:value ... 형태의 자료구조)
set member:info:1 "{\"name\":\"hong\", \"email\":\"hong@daum.net\", \"age\":30}" 
hset set member:info:1 name hong email hong@daum.net age 30
# 특정값 조회
hget member:info:1 name
# 모든객체값 조회
hgetall member:info:1 
# 특정 요소값 수정
hset member:info:1 name hong2
# redis활용상황 : 빈번하고 변경되는 객체값을 저장시 효율적