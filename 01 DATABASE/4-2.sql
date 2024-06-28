create database naver_db;
use naver_db;

create table member
(
   mem_id char(8) not null,
   mem_name varchar(10) not null,
   mem_number tinyint not null,
   addr char(2) not null,
   phone1 char(3) null,
   phone2 char(8) null,
   height tinyint unsigned null,
   debut_date date null,
   primary key(mem_id)
);

desc member;
# unsigned는 null 제약조건 앞에 넣어준다.

create table buy
(
   num int not null primary key auto_increment,
   mem_id char(8) not null ,
   prod_name char(6) not null,
   group_name char(4) null,
   price int unsigned not null,
   amount smallint unsigned not null,
   foreign key (mem_id) references member(mem_id)
); 
# 포린키 빼먹어서 추가하고 싶다면?
# alter table buy add constraint foreign key (mem_id) references member(mem_id)
#포린키는 왜 쓸까?
# 참조무결성 때문 


desc buy;

insert into `member`
values ('TWC','트와이스',9,'서울','02','11111111',167,'2015-10-19'),
('BLK', '블랙핑크', 4, '경남','055', 22222222,163, '2016-08-08'),
('WMN', '여자친구', 6, '경기', '031', 33333333,166,'2015-01-15'),
('OMY', '오마이걸', 7, '서울', null, null, 160, '2015-04-21'),
('GRL', '소녀시대', 8, '서울', '02', 44444444,168,'2007-08-02'),
('ITZ', '잇지', 5, '경남', null, null,167, '2019-02-21'),
('RED', '레드벨벳', 4, '경북', '054', 55555555,161, '2014-08-01'),
('APN', '에이핑크', 6, '경기', '031', 77777777,164, '2011-02-10'),
('SPC', '우주소녀',13, '서울', '02', 88888888,162, '2016-02-25'),
('MMU', '마마무', 4, '전남', '061', 99999999,165, '2014-06-19');

select* from member;

# 오토 인크리먼트는 인서트 할때 칼럼명을 반드시 넣어 주어야 한다. (오토 인크리먼트 칼럼명은 제외)
insert into `buy` (mem_id, prod_name, group_name,price, amount)
values ('BLK','지갑',null,30,2),
('BLK', '맥북프로', '디지털',1000,1),
('APN', '아이폰', '디지털',200,1),
('MMU', '아이폰', '디지털',200,5),
('BLK', '청바지', '패션',50,3),
('MMU', '에어팟', '디지털',80,10),
('GRL', '혼공SQL', '서적',15,5),
('APN', '혼공SQL', '서적', 15,2),
('APN', '청바지','패션', 50,1),
('MMU', '지갑', null, 30,1),
('APN', '혼공SQL','서적',15,1),
('MMU', '지갑', null,30,4);

select* from buy;


#두 테이블을 inner join 하시오
select * from member as m
inner join buy as b on m.mem_id= b.mem_id;

select * from member as m
left join buy as b on m.mem_id= b.mem_id;

select * from member as m
right join buy as b on m.mem_id= b.mem_id;

#서브쿼리
#쿼리 안에 또 다른 쿼리를 이용해서 원하는 데이터를 조회
#이름이 에이핑크인 회원의 평균키(height)보다 큰 회원을 조회하기
#쿼리를 한번써서 한번에 처리하겠다! (자동화)

select mem_name, height from member
where height > (
select height from member 
where mem_name = '에이핑크');


