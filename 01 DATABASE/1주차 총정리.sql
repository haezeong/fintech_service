use titanic;
show tables;
select * from p_info;
select Name, Age from p_info;
select Name, Age from p_info limit 3;
select Name, Age from p_info where Age=25;
select Name, Age from p_info where Age >= 30;

select Name, Age from p_info where Sex <> "male";
select Name, Age from p_info where Sex <> "male" && Age=25;
select Name, Age from p_info where Sex <> "male" or Age=25;

select * from p_info where Age >=20 and Age < 50 and Sex <> "male";
select * from p_info where SibSp >=1 and parch >=1;
select * from t_info where Pclass =1;
select * from t_info where Pclass =2 or Fare >50;
select * from survived where survived =1;

select * from p_info where Name like 'Braund%';
select * from p_info where Name like '%Mrs%';
select * from p_info where Name Not like '%Mrs%';

#in을 써주면 쿼리가 훨씬 간결해진다. 
select * from p_info where Sibsp=2 or Sibsp=3 or Sibsp=4 or Sibsp=5;
select * from p_info where Sibsp in(2,3,4,5,6);
#Not in
#between a and b = a이상 b이하
#p_info Age가 40이상, 60이하인 사람을 검색하시오
select * from p_info where Age >=40 and Age <= 60;
select * from p_info where Age between 40 and 60;

#is NULL/ is not NULL (결측치, 값이 없음)
select * from p_info where Age is null;
select * from p_info where Age is not null;

select * from t_info where Fare between 100 and 1000;

select * from t_info where Ticket like 'PC%' and Embarked = ('C'or'S');
select * from t_info where Ticket like 'PC%' and Embarked in ('C','S');

select * from t_info where Pclass in(1,2);
select * from titanic.t_info;
select * from t_info where Cabin like '%59%';
select * from p_info where Age is not null and Name like '%James%' and Age >=40;

#order by 칼럼명 desc, asc
select * from p_info where Age is not null and Name like '%Miss%' and Age <=40 order by Age DESC;

#group by
select sex, avg(age) from p_info where Age is not null group by sex;
select sex, avg(age), Min(age), Max(age) from p_info where Age is not null group by sex;
#group by - Having
select Pclass, avg(Fare) from t_info Group by Pclass having Avg(Fare);

#inner join (교집합)- 기준 칼럼을 비교해 양쪽에 데이터가 있는 행만 합쳐줌.
#select * from 테이블1 as 별칭 inner join 테이블2 as 별칭2
#on 테이블1의 기준컬럼 = 테이블2의 기준컬럼;
select * from passenger;
select * from ticket;
select * from passenger as p inner join ticket as t on p.PassengerId = t.PassengerId;
#중복 컬럼 이름 오류조심 -select절에 as별칭 꼭 사용해서 정확하게 명시해주기 -> from~이후 dlfrrh aos akwlakrdp select 처리해주기 때문에alter
select p.PassengerId, Name from passenger as p inner join ticket as t on p.PassengerId = t.PassengerId;

#left join
select * from passenger as p left join ticket as t on p.PassengerId = t.PassengerId;
#right join
select * from passenger as p right join ticket as t on p.PassengerId = t.PassengerId;

#full outer join : mysql에서 지원 X, union이란 명령어로 left join 결과와 right join 결과를 합침
select * from passenger as p left join ticket as t on p.PassengerId = t.PassengerId
union
select * from passenger as p right join ticket as t on p.PassengerId = t.PassengerId;

#원하는 칼럼만 조회하기 : 컬럼명을 그대로 적어준다. 단, 컬럼명이 중복되면 어느 테이블인지 명시한다.
select p.PassengerId, p.Name, p.age, t.Pclass, t.Embarked 
from passenger as p 
left join ticket as t 
on p.PassengerId = t.PassengerId;

#3개 이상의 테이블 조인
#passenger, ticket, survived inner join 합쳐서 전체 칼럼을 출력하시오.
select * from passenger as p
inner join ticket as t
on p.PassengerId = t.PassengerId
inner join survived as s
on p.PassengerId = s.PassengerId;


create database testsb;
use testsb;
#테이블 생성
create table testtable
( student_no int not null primary key,
student_name varchar (100) not null,
grade tinyint,
class varchar(50),
gender varchar(20),
age smallint,
enter_date datetime);
#컬럼이름- 데이터 타입 지정 -제약조건
#내가 만든 컬럼의 컬럼명외에 데이터타입이 뭔지 널인지 아닌지, 프라이머리키는 뭔지 자세하게 알수있다.
#desc, describe
#생성한 테이블의 속성 조회
describe testtable;
desc testtable;

#테이블에 데이터를 입력
#insert into `테이블명` (컬럼명) values(값)   #테이블명은 빽틱으로 감싸주는 것 잊지 말기! esc아래 키 
insert into `testtable`
(student_no, student_name, class, gender, age, enter_date)
values (1, '홍길동', 1, '1반', '남자', 20, '2024-03-02');
#데이터 여러개 넣으려면 그뒤에 연이어서 적어주면 된다.

#잘들어갔는지 확인
select * from testtable;

#컬럼명은 원래는 적어주는게 맞지만  위치 바꿔 출력하는 것 외에는 보통생략한다
insert into `testtable`
values (1, '홍길동', 1, '1반', '남자', 20, '2024-03-02'),
(2, '홍길', 1, '11반', '남자', 20, '2024-03-02'),
(3, '길동', 1, '10반', '남자', 25, '2024-03-02'),
(4, '홍동', 1, '8반', '남자', 27, '2024-03-02');
#컬럼을 직접 지정한다면 바뀐 것에 맞게 변경해서 넣어주어야 함
#프라이머리 키 중복되지 않도록 넣어주는 것 중요 
#입력할때 순서 바뀐다고 테이블컬럼위치가 바뀌지 않는다. -> 보여지는 것은 테이블 만든 순서에 맞게 들어간다.



#테이블에 데이터 입력하는 것 까지 하고, 나머지는 파일 뭐리 불러와서 넣어줌
#쿼리 불러오는데 문제가 발생했었음 (인코딩 문제) 
#인코딩이 맞지 않는다고 해서 무시하고 불러봤는데 한글깨짐현상 발생 
#sql파일 저장할때 utf-8로 저장하지 않고, 다른것으로 저장되어 있었음.alter(주로 utf-8지원)
#확인하는 법- 메모장으로 파일열어서 확인 -메모장의 오른쪽 아래보면 파일이 뭐로 저장되어있는지 알 수 있음. 
#인코딩 바꿔서 저장 후에 다시 업로드 해준다. 


# sql 함수
#숫자함수, 문자함수, 날짜함수
#함수 사용하는 법
#그냥 적는게 아니라 select와 함께 적는다. from은 x
# select 함수(값)
#절대값
select abs(1), ABS(-1);
#앞에 select가 온다
# 별도로 from이 오지 않는다

#문자열의 길이 측정 : LENGTH(문자열);
select length('mysql');

#실수에서, 소수점이 길어지면 반올림 -> round 함수
select round(3.124567, 2) ;

# 숫자형 함수 =, -, *, / (나눗셈) , %(나머지)= mod, div(몫) -> 나눗셈했을 때 몫만 반환
select 7%2; #나머지 반환
select 7 mod 2; #나머지 반환
select 7 div 2; #몫만 반환 
select 7 / 2; 

#올림 -> ceil, 내림 함수 -> floor
select ceil(4.5);
select floor(4.5);

# 제곱, 루트, 음수 양수 확인
select power (4,3);
select sqrt(3);
select sign(-55); #음수면 -1 반환
select sign(777); #양수면 1 반환

#round (값, 자릿수) 반올림
select round(3.1234567); #자릿수 지정을 안하면 소숫점 없음.
select round(3.1234567,2); #소숫점 자릿수만큼 나타내줌 (소수점 (자릿수+1)째 자리에서 반올림)

# truncate(값, 자릿수) 버림
select round (2.2345, 3), truncate (2.2345, 3);
select round(1153.456, -2), truncate(1153.456, -2); #마이너스 붙으면 일(-1)십(-2)백(-3)천(-4)자리에서 반올림해서 출력 

#문자형 함수 
#문자의 길이를 알아보는 함수
select char_length('sql'), length('sql'), char_length('홍길동'), length('홍길동'); #한글 영어 상관업이 문자길이 알고 싶을때는 char legth를 써야 하고, 바이트를 알고싶을때는 length를 사용하면 된다. 
# 한글은 한자에 3바이트씩, 영어는 1바이트

#문자를 연결하는 함수 concat(), concat_ws()
select concat('this','is', 'mysql') as concat1; #공백없이 문자를 합침
select concat('this', null, 'mysql') as concat1; #중간에 null이 있으면 null이 됨 
select concat_ws(':', 'this','is', 'mysql') as concat3;
#concat주의할점 -> 중간에 널이 있으면 널이된다.

#대문자를 소문자로 소문자를 대문자로
select lower('ABsd');
select upper('ABsd');

#lpad, rpad 문자열의 자릿수를 일정하게 하고, 빈공간을 지정한 문자로 채우기
#lpad(값, 자릿수, 채울문자), rpad(값, 자릿수, 채울문자)

select lpad('SQL', 7, '#');
select rpad('SQL', 7, '#');
select lpad('SQL', 7, '                    ');

#공백을 없애는 함수. -> ltrim(문자열), rtrim(문자열)
select ltrim(' SQL            ');
select rtrim('               SQL            ');

#문자열을 잘라내는 함수 -> left(문자열, 길이), right(문자열, 길이)
select left('this is my sql', 4), right('this is my sql', 4);

#문자열의 중간에서 잘라내는 함수 substr(문자열, 시작위치, 길이)
select substr('this is my sql', 6, 2);
select substr('this is my sql', 6); #길이 부분을 생략하면 시작위치 이후 모두를 가져오게 된다. 

#문자열의 공백을 앞 뒤로 삭제 -> trim
select trim('      mysql                ');
select trim(leading '*' from '****mysql******'); #문자열 앞쪽의 *을 없앰.
select trim(trailing '*' from '****mysql******'); #문자열 뒷쪽의 *을 없앰.
select trim(both '*' from '****mysql******'); #문자열 양쪽의 *을 없앰.

# 날짜형 함수
select curdate(); #현재 날짜 (년월일) 출력
select current_date();
select curtime();  #현재 시간
select current_time();
select now(); #현재 날짜, 시간 두개가 같이 나온다
select current_timestamp(); # =now와 동일하게 현재 년월일 + 현재 시분초
 

#요일 표시 함수 dayname(날짜)
select dayname(now());

#dayofweek(날짜) -> 일주일 중 오늘이 몇번 째 날인지 : 일1-월2-화3-수4-목5-금6-토7
select dayofweek(now());
# dayofyear(날짜) -> 1년중 오늘이 몇일째인지
select dayofyear(now());

#날짜를 세분화해서 보는 함수들
#현재 달의 마지막 날이 몇 일까지 있는지 출력해주는 함수 
select last_day(now());
select last_day('2024-02-10');
select last_day('2023-02-10');

# 입력한 날짜에서 연도만 추출
select year(now());
# 달만 추출
select month(now());
# 몇 분기인지 출력 
select quarter(now());
# 몇 주차인지
select weekofyear(now()); 

#날짜와 시간이 같이 있는 데이터에서 날짜 따로 시간 따로 구분해 주는 함수
select now();
select date('2024-06-27 17:23:30');
select time('2024-06-27 17:23:30');


#날짜를 지정한 날 수 만큼 더하는 함수 -> date_add(날짜, interval 더할 날 수 day)
select date_add(now(), interval 5 day);
select adddate(now(), 5);

#날짜를 지정한 날 수 만큼 빼는 함수 ->  subdate(날짜, interval 뺄 날 수 day), subdate(날짜, 뺄 날 수)
select subdate(now(), interval 5 day);
select subdate(now(), 5);

#날짜와 시간을 년월, 날시간, 분초 단위로 추출하는 함수
#extract(옵션, from 날짜시간)
select extract(year_month from now());
select extract(day_hour from '2024-06-27 17:35:30');
select extract(minute_second from '2024-06-27 17:35:30');
select extract(minute_second from now());

#날짜 1에서 날짜2를 뺀 일 수를 반환
#datediff(날짜1, 날짜2)
select datediff(now(), '2024-06-25');

#날짜 포멧 함수 지정한 형식에 맞춰서 출력해주는 함수 
# %Y 4자리 연도, %y 2자리 연도 
# %m 2자리 월 표시, %M 월의 영문 표기, %b 월의 축약 영문표기 Jan
# %d 2자리 일 표기, %e 1자리 일 표기

select date_format(now(), '%d-%b-%Y');
select date_format(now(), '%Y-%b-%d');
select date_format(now(), '%Y-%m-%e');

# 시간 포멧
# %H 24시간 표기, %h 12시간 표기, %p AM, PM 표시 
# %i 2자리 분 표기
# %S 2자리 초 표기
# %T 24시간 표기법 시:분:초 
# %r 12시간 표기법 시:분:초 AM/PM
# %W 요일의 영문표기, %w 숫자로 요일 표시  

select date_format ('2024-06-01 10:22:30', '%h:%i:%S %p');
select date_format ('2024-06-01 10:22:30', '%T');
select date_format ('2024-06-01 10:22:30', '%r');
select date_format ('2024-06-01 10:22:30', '%W');
select date_format ('2024-06-01 10:22:30', '%w');

#str_to_date('문자열', 출력 포멧)
select str_to_date('21,01,2021', '%d, %m, %Y');
select str_to_date('19:30:17', '%H:%i:%s');
#시간을 바꿀대 주의해야할 점 ->소문자 h는 12까지만 표기가능한데 24시간 표기로 포멧이 되어있으면 표현 불가
select str_to_date('19:30:17', '%h:%i:%s'); # -null ->표기랑 포맷이랑 다르기 때문에 표현 불가

# sysdate() 현재 날짜와 시간 반환
select sysdate();
select sysdate(), sleep(2), sysdate();
select now(), sleep(2), now();
#나우는 내가 실행한 시간만 찍어주는 반면, 시스데이트는 흐른시간도 찍어준다 

# 현재 날짜를 기준으로 현재 일이 속한 월의 마지막 날짜에
# 해당하는 요일을 구하는 쿼리를 작성하세요.
select dayname(last_day(now()));



# 형 변환 함수 : 형 변환 데이터 타입을 변환하는 함수
#char() char 타입으로 변환
#signed() 정수형(int)으로 변환
#float() float타입으로 변환
#date() date 타입으로 변환
#datetime() datetime 타입으로 변환
# CAST( 값 as 변환할 데이터 타입)

select cast(10 as char);
select cast('-10' as signed);
select cast('10.1234' as decimal);
select cast('10.1234' as decimal(6, 4));
select cast('10.1234' as double);
select cast('2021-10-31' as date);
select cast('2021-10-31' as datetime);

#주어진 자료에 시간이 없으니까 00:00:00으로 형변환이 된다. 
#같은 역할을 하지만 이름이 다른 함수들이 꽤 있다.
#cast와 convert는 동일한 기능  
select convert(10, char);
select convert('-10', signed);
select convert('10.1234', decimal);
select convert('10.1234', decimal(6, 4));
select convert('10.1234', double);
select convert('2021-10-31', date);
select convert('2021-10-31', datetime);
 
 
#이런 함수를 도대체 어디에 써먹나?
#출력 컬럼 이름을 concat으로 합쳐서 출력하기 
use world;
#world의 country 테이블에서 인구가 4500만명- 5500만명 사이에 있는 국가 조회.
# code, name, continent, reigion, population 출력 
# name(continent)로 출력되도록 
select * from country;
select code, concat(`name`,'(',`continent`,')') as info, region, population from country
where population between 45000000 and 55000000;

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