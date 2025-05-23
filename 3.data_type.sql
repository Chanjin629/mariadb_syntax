-- tinyint : -128~127까지 표현
-- author테이블에 age컬럼 변경
alter table author modify column age tinyint unsigned;
insert into author(id,email, age) values(6, 'abc@naver.com', 300);

-- int : 4바이트(대략, 40억 숫자범위)

-- bigint : 8바이트
-- author, post테이블의 id값 bigint변경
alter table author modify column id bigint;

-- decimal(총자리수, 소수부자리수)
alter table post add column price decimal(10,3);
-- decimal 소수점 초과시 짤림현상발생생
insert into post(id,title,price,author_id) values(2,'hello python', 10.33412,3);

-- 문자타입 : 고정길이(char), 가변길이(varchar, text)
alter table author add column gender char(10);
alter table author add column self_introduction text;

-- blob(바이너리데이터) 타입 실습
-- 일반적으로 blob으로 저장하기 보다, varchar로 설계하고 이미지경로만을 저장함.
alter table author add column profile_image longblob;
insert into author(id,email,profile_image)values(3,'aaa@naver.com',LOAD_FILE('C:\\TEST.jpg'));

-- enum : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입
-- role 컬럼 추가
alter table author add column role enum('admin', 'user') not null default 'user';
-- enum에 지정된 값이 아닌경우
insert into author(id,email,role) values(9,'ddd@naver.com','admin2');
-- role을 지정 안한경우
insert into author(id,email) values(10,'ccc@naver.com');
-- enum에 지정된 값이 경우
insert into author(id,email,role) values(11,'eee@naver.com','admin');

-- date와 datetime
-- 날짜타입의 입력,수정,조회시에 문자열 형식을 사용
alter table author add column birthday date;
alter table post add column created_time; datetime;
insert into post(id,title,author_id,created_time)values(3,'hello',3,'2025-05-23 14:36:30'); 
alter table post modify column created_time datetime default current_timestamp();
insert into post(id,title,author_id) values(10,'hello',3)

-- 비교연산자
select * from author where id>=2 and id<=4;
select * from author where id between 2 and 4;
select * from author where id in(2,3,4);

-- like : 특정문자를 포함하는 데이터를 조회 하기위한 키워드
select * from post where title like 'h%';
select * from post where title like '%h';
select * from post where title like '%h%';

-- regxp : 정규표현식을 활용한 조회
select * from post where title regexp '[a-z]' -- 하나라도 알파펫 소문자가 들어있으면면
select * from post where title regexp '[가-힣]' -- 하나라도 한글이 있으면면

-- 날짜변화 : 숫자 -> 날짜
select case(20250523 as date);
-- 문자 -> 날짜
select cast('20250523' as date);
-- 문자 -> 숫자
select cast('12' as unsigned);

-- 날짜조회 방법
-- like패턴, 부등호 활용, date_format
select * from post where created_time like '2025-05%'; --문자열처럼 조회
-- 5월1일부터 5월20일까지지
select * from post where created_time >= '2025-05-01' and created_time <'2025-05-21'

select date_format(created_time, '%Y-%m-%d') from post; -- 소문자 y는 두자리 년도도
select date_format(created_time, '%H:%i:%s') from post; -- 소문자 h는 12시간 형식
select * from post where date_format (created_time, '%m') = '05';

select * from post where cast(date_format(create_time, '%m') as unsigned) = 5;