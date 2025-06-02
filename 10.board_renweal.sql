-- 복합키를 이용한 연결테이블생성
create table author_post2
(author_id bigint not null, post_id bigint not null, 
primary key(author_id, post_id),
foreign key(author_id) references author(id), 
foreign key(post_id) references post(id));

-- 회원가입및 주소생성
DELIMITER //
create procedure insert_author(in emailInput varchar(255), in nameInput varchar(255), in passwordInput varchar(255),in countryInput varchar(255),in cityInput varchar(255),in streetInput varchar(255))
begin
    declare exit handler for SQLEXCEPTION
    begin 
        rollback;
    end;
    start transaction;
    insert into author(email,name,password) values(emailInput,nameInput,passwordInput); 
    insert into address(author_id,country,city,street) values((select id from author order by id desc limit 1), 'korea', 'seoul', 'dongjak');
    commit;
end //
DELIMITER ;

-- 글쓰기
DELIMITER //
create procedure insert_post(in titleInput varchar(255), in contentsInput varchar(255), in emailInput varchar(255))
begin
    declare exit handler for SQLEXCEPTION
    begin
        rollback;
    end;
    start transaction;
    insert into post(title, contents) values (titleInput, contentsInput);
    insert author_post(author_id, post_id) values((select id from author where email=emailInput), (select id from post order by id desc limit 1));
    commit;
end //
DELIMITER ;

-- 글편집 하기기
DELIMITER //
create procedure edit_post(in titleInput varchar(255), in contentsInput varchar(255), in emailInput varchar(255), in idInput bigint)
begin
    declare exit handler for SQLEXCEPTION
    begin
        rollback;
    end;
    start transaction;
    update post set title=titleInput set contents=contentsInput where id=idInput; 
    insert author_post(author_id, post_id) values((select id from author where email=emailInput), idInput);
    commit;
end //
DELIMITER ;

-- JOIN하여 데이터 조회
select p.title as '제목', p.contents as '내용', a.name as '이름' from post p inner join author_post ap on p.id=ap.post_id
inner join author a on a.id=ap.author_id;