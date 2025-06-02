-- 사용자관리
-- 사용자목록조회
select * from mysql.user;

-- 사용자생성
create user 'chanjinkim'@'%' identified by '4321';

-- 사용자에게 권한부여
grant select on board.author to 'chanjinkim'@'%';
grant select, insert on board.* to 'chanjinkim'@'%';
grant all privileges on board.* to 'chanjinkim'@'%';

-- 사용자 권한회수
revoke select on board.author from 'chanjinkim'@'%';
-- 사용자 권한 조회
show grants for 'chanjinkim'@'%';

-- 사용자 계정삭제
drop user 'chanjinkim'@'%';