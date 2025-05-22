-- insert : 테이블에 데이터 삽입
insert into 테이블명(컬럼1, 컬럼2, 컬럼3) values(데이터1, 데이터2, 데이터3);
insert into author(id, name, email) values(3, 'hong3', 'hong3@naver.com'); --문자열 보통 작은 따옴표를 사용한다
-- update : 테이블에 데이터 변경
update author set name= "홍길동", email="hong100@naver.com" where id=3;
-- select : 조회
select 컬럼1, 컬럼2 from 테이블명;
select name, email from author;
select * from author;
-- delete : 삭제\
delete from 테이블명 where 조건절;
delete from author where id=3;

-- select 조건절 활용 조회
-- 테스트 데이터삽입 : insert 문을 활용해서 author 데이터 3개, post 데이터 5개개
select * from author; -- 어떤 조회조건없이 모든 컬럼 조회
select * from author where id =1; --where 뒤에 조회조건을 통해 filtering
select * from author where name ='honggildong';
select * from author where id>3;
select * from author where id>2 and name = 'hong4';

-- 중복제거 조회 : distinct 
select name from author;
select distinct name from author;

-- 정렬 : order by : 컬럼명 
-- asc : 오름차순, desc : 내림차순, 안붙이면 오름차순(default) 
-- 아무런 정렬조건없이 조회할 경우에는 pk 기준으로 오름차순
select * from author order by name;

-- 멀티컬럼 order by : 여러컬럼으로 정렬시에, 먼저쓴컬럼 우선정렬. 중복시, 그다음 정렬옵션적용
select * from author order by name desc, email asc; --name으로 정렬후, name이중복되면 email로 정렬.

-- 결과값 개수 제한
select * from author order by id desc limit 1;

-- 별칭(alias)를 이용한 select
select name as '이름', email as '이메일' from author;
select a.name, a.email from author as a;
select a.name, a.email from author a;

-- null을 조회조건으로 활용
select * from author where password is null;
select * from author where password is not null;

-- 프로그래머스 