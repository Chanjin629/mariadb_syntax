-- mariadb 서버에 접속
mariadb -u root -p --입력후 비밀번호 별도 입력

-- 스키마(database) 생성
CREATE DATABASE board; --소문자로 써도 상관없음, 대문자로 쓰는게 표준

-- 스키마 삭제
drop database board;

-- 스키마 목록 조회
show databases;

-- 스키마 선택
use 스키마명;

-- 문자인코딩 변경
alter database board default character set = utf8mb4;

-- 문자인코딩 조회
show variables like 'character_set_server';

-- 테이블생성
create table author(id int primary key, name varchar(255), email varchar(255), password varchar(255));

-- 테이블 목록조회
show tables;

-- 테이블 컬럼정보 조회
describe author;

-- 테이블 생성명령문 조회
show create table author;

-- posts테이블 신규생성(id, title, contents, author_id)
create table posts(id int, title varchar(255), contents varchar(255), author_id int not null, primary key(id), foreign key(author_id) references author(id));

-- 테이블 제약조건 조회
select * from information_schema.key_column_usage where table_name='posts';

-- 테이블 index 조회
show index from author;

-- alter : 테이블의 구조를 변경
-- 테이블의 이름 변경
alter table posts rename post;

-- 테이블의 컬럼 추가
alter table author add column age int;

-- 테이블 컬럼 삭제
alter table author drop column age;

-- 테이블 컬럼명 변경
alter table post change column contents content varchar(255); 

-- 테이블 컬럼의 타입과 제약조건 변경 => 덮어쓰기
alter table author modify column email varchar(100) not null;
alter table author modify column email varchar(100) not null unique; --제약조건과 타입을 추가시키고 싶으면 이미 적용된 제약조건과 타입을 다시 추가해줘야한다다

-- 실습 : author 테이블에 address컬럼을 추가(varchar255)
alter table author add column address varchar(255);
-- 실습 : post테이블에 title은 not null로 변경, content는 길이 3000자로 변경경
alter table post modify column title varchar(255) not null, modify column content varchar(3000);

-- drop : 테이블을 삭제하는 명령어
drop table abc;
-- 일련의 쿼리를 실행시킬때 특정 쿼리에서 에러가 나지 않도록 if exists룰 많이 사용.
drop table if exists abc;