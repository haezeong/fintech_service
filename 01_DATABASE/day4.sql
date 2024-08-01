#CRUD 연습 
use mywork;
#새로운 테이블 생성
create table emp_test
(
   emp_no int not null,
   emp_name varchar(30) not null,
   hire_date date null,
   salary int null,
   primary key(emp_no)
);

desc emp_test;

insert into `emp_test`
values (1001, '아인슈타인', '2021-01-01', 1000);

select * from emp_test;

insert into `emp_test`
values (1002, '갈릴레이', '2021-02-10', null);

insert into `emp_test`
values (1003, '뉴턴', '2021-02-10', null),
(1004, '파인먼', '2021-03-01', 3000),
(1005, '퀴리', '2021-04-01', 2200),
(1006, '호킹', '2021-03-05', 5000),
(1007, '페러데이', '2021-04-01', 2200),
(1008, '맥스웰', '2021-04-05', 3300),
(1009, '플랑크', '2021-04-05', 4400);


#인서트 인투로 한번 입력하면 끝.
#잘못 입력해서 수정하고싶으면 'update'라는 명령어를 쓴다
# update 테이블 set 컬럼1= 값, 컬럼2= 값 where 찾을 값 
#삭제랑 업데이트는 굉장히 중요하다. 데이터가 한번에 삭제되고 전체가 업데이트 될 수 있기에 조심해야 한다.

update emp_test
set salary = 50 where emp_no = 1002;
#프라이머리키가 아닐 경우에는 중복이 있을 수 있으니 프라이머리키로 지정되지 않은 칼럼은 사용 불가하다 
#primary키가 지정된 칼럼이 아니면 where절에서 사용 못함
#업데이트를 where절에 뭔가를 주지 않고 썼을 경우에는 컬럼 전체가 모두 바뀌기 때문에 주의 -> 데베 자체에서 막아두었다
update emp_test
set salary = 1000000;


# 테이블 데이터 수정하기
# 아인슈타인 1000, 갈릴레이 null, 뉴턴 null, 파인먼 3000, 퀴리 4000, 호킹 5000, 페러데이2200, 맥스웰 3300, 플랑크 4400
 select * from emp_test;
 update emp_test
 set salary = 4400 where emp_no = 1009;
 
 #delete문으로 데이터 삭제하기
 #delete from 테이블 where 조건
 #딜리트도 웨어절 없이 쓰면 사고, 모두 다 지워버리는 것
 delete from emp_test;
 select * from emp_test;
 

insert into `emp_test`
values (1001, '아인슈타인', '2021-01-01', 1000),
(1002, '갈릴레이', '2021-02-10', null),
(1003, '뉴턴', '2021-02-10', null),
(1004, '파인먼', '2021-03-01', 3000),
(1005, '퀴리', '2021-04-01', 2200),
(1006, '호킹', '2021-03-05', 5000),
(1007, '페러데이', '2021-04-01', 2200),
(1008, '맥스웰', '2021-04-05', 3300),
(1009, '플랑크', '2021-04-05', 4400);

#트렌젝션 처리하기 
#돈을 보냈는데 중간에 오류생겨서 접속이 끊겼을때 돈이 공중분해되는 것을 방지하고자, 원상복귀하고자 ->roll back
#원래 쿼리 끝에 commit을 해줘야 완벽하게 마무리 된것.
#mysql은 오토 커밋이어서 자동으로 커밋된다. 

#오토 커밋 옵션 활성화 확인
#select @@autocommit 1= 활성화, 0= 비활성화
select @@autocommit;
#오토 커밋 설정 set autocommit = 0/1
set autocommit = 0;
select @@autocommit;

select* from emp_test;
#다른 테이블에서 내용을 가져와 테이블을 생성(복사)하는 법 
create table emp_tran1 as select* from emp_test;

select * from emp_tran1;
desc emp_tran1;
alter table emp_tran1 add constraint primary key (emp_no);

create table emp_tran2 as select * from emp_test;
select * from emp_tran2;
alter table emp_tran2 add constraint primary key(emp_no);
desc emp_tran2;

delete from emp_tran1;
select * from emp_tran1;
rollback;
#다행이 오토커밋을 꺼놔서 롤백을 할 수 있다. 커밋 전가지는 다시 되돌릴 수 있다. 승인 완료 이전 단계 

select* from emp_tran1;
#원래는 모든 쿼리 이후에 커밋이 들어가야 한다. 

#커밋을 날리기 전에 운좋게 백업해두었으면 리스토어 할 수 있는데, 아니면 절대 복구 불가
#커밋은 무서운 것이다. 잘 기억하고 쓰자.

delete from emp_tran1;
select * from emp_tran1;
commit;
rollback;
select * from emp_tran1;

#은행 같은 경우는 양쪽 확인이 되었을 때 커밋이 이루어져야 할것이고, 상황에다라 다르다. 
#오토 커밋을 매번치기 귀찮은 업무일 경우, 복원이 크게 중요하지 않은 경우에는 오토 커밋 사용
#delete와 update는 rollback이되지만 drop은 rollback이 되지 않는다.


