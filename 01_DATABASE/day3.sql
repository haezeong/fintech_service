#데이터베이스는 엑셀파일 하나 만드는 거와 비슷하다
#테이블 만들기 전 데이터베이스부터 생성 
#그래픽 환경으로도 생성가능- 오른쪽 마우스 클릭 후 create 스키마
#쿼리로 생성 - 실제에서는 gui보다 sql이용해서 ㅁ만드는 경우가 더 많을 것 
# CREATE SCHEMA 와 CREATE database 모두 생성가능
CREATE SCHEMA `testdb` ;
CREATE database `testdb2` ;

#이미 존재할 때, 경고 안 뜨게 데이터베이스 생성 법 = if옵션준다-> 없으면 만들고, 이미 만들어져 있으면 x
#한번에 쿼리 실행하는 경우 있음 중간에 오류로 중단되지 않으려면 필요하다
#존재하지 않으면 만들어라
CREATE database if not exists `testdb2` ;
CREATE database if not exists `testdb3` ;

#데이터베이스 삭제 = drop 
Drop database testdb3;
Drop schema testdb;
#옵션 넣기 - 존재하면 삭제해라 
Drop database if exists testdb2;

# 실습 시작 
# 데이터베이스 생성
create database if not exists mywork;

# 테이블 생성, 컬럼 생성
#데이터베이스 만들고나서 열어줘야 사용이가능하다 -> 반드시 use 사용해서 파일을 열어주자 
use mywork;
show tables;
select * from mywork.student_info;
drop table if exists student_info;

#테이블을 만들때 주의할 사항alter#식별자 명명 규칙
#식별자 : 데이터베이스 이름, 테이블 이름, 컬럼명 
#따라야하는 규칙 만들어 놓음 
#1. 최대길이 64 글자까지 가능
#2. 사용가능 문자 0-9, 영문자, 한글, $, _를 사용할 수 있다.
#3. 예약어(create, database, avg, show)는 사용할 수 없다.
#4. 대소문자 구분 (windoes는 관계없음), linux, unix는 대소문자 구분

# 컬럼 생성시 주의사항
#1. 한 테이블에 최대 4,096 개 까지 컬럼을 만들 수 있다.
#2. 한 테이블에서 같은 컬럼명을 사용할 수 없다.
#3. 데이터베이스 내에서 같은 테이블명도 사용할 수 없다.

#sql을 사용해서 테이블 만들기 -> create 테이블명
#gui가 아닌 쿼리로 만들기
#주의 - 내가 어떤 데이터베이스를 사용하고 있는지 반드시 확인할 것.
#use를 이용해서 활성화하지 않고 쿼리 작성하는 경우 오류가 날 수 있다.

use mywork;
create table highschool_students
(
  student_no varchar(20),
  student_name varchar(100),
  grade tinyint,
  class varchar(50),
  gender varchar(20),
  age smallint,
  enter_date date
  );
  
#생성한 테이블의 구조를 출력 -> describe, desc
describe highschool_students;
desc highschool_students;

# 제약조건을 넣어서 만들기 -> null, not null
create table highschool_students2
(
  student_no varchar(20) not null, #한컬럼을 만드는 내에서는 콤마가 들어가지 않는다. 제약조건 콤마 없이 쓰기!
  student_name varchar(100) not null,
  grade tinyint null,
  class varchar(50) null,
  gender varchar(20) null,
  age smallint null,
  enter_date date 
  );
  
  #위에서 만든거 확인하는 명령어 = desc, describe
  describe highschool_students2;
  #삭제는
  drop table highschool_students;
  
# 기본키를 포함해서 만들기 (기본키 : primary key)
create table highschool_students
(
  student_no varchar(20) not null primary key, 
  student_name varchar(100) not null,
  grade tinyint null,
  class varchar(50) null,
  gender varchar(20) null,
  age smallint null,
  enter_date date 
  );

#기본키 명령어를 마지막에 적는 경우
desc highschool_students;
drop table highschool_students;

create table highschool_students
(
  student_no varchar(20) not null,
  student_name varchar(100) not null,
  grade tinyint null,
  class varchar(50) null,
  gender varchar(20) null,
  age smallint null,
  enter_date date,
  primary key (student_no)
  );
  
desc highschool_students;
drop table highschool_students;

# constraint primary key로 기본키 설정하기
create table highschool_students
(
  student_no varchar(20) not null,
  student_name varchar(100) not null,
  grade tinyint null,
  class varchar(50) null,
  gender varchar(20) null,
  age smallint null,
  enter_date date,
  constraint primary key (student_no)
  );
  
desc highschool_students;

#기본키 삭제하기 -> alter
#alter는 만들어진 데이터베이스나 테이블을 수정할 때 사용하는 명령어 
#gui에서는 네비게이터에서 만들어진 테이블의 공구모양 누르면 수정가능
alter table highschool_students drop primary key;
desc highschool_students;

#기본 키 추가하기 -> alter add
alter table highschool_students add primary key(student_no);
desc highschool_students;

#기본 키 생성시 주의사항
#1. 한 테이블에서 기본키는 1개만 생성할 수 있다.
#2. 1개 이상의 컬럼으로 기본키를 생성할 수 있다. 
#3. 기본키 컬럼에는 반드시 not null을 적용한다.


