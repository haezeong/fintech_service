use mywork;
select * from highschool_students;
#테이블에 자료를 넣는 법
#insert into `테이블명` (컬럼명1, 컬럼명2..) values (컬럼1 데이터, 컬럼2 데이터); 
#빽틱을 이용해서 테이블명을 감싸줘야한다
#데이터 타입에 맞춰서 넣어줘야 한다.

insert into `highschool_students` (student_no, student_name, grade, class, gender, age, enter_date)
values ('TB0002', '둘리', 1, '11반', '남자', 20, '2024-03-02');


#데이터 타입이랑 컬럼명을 정확하게 알고 있을 때 가능
#컬럼명 순서 변경과 같은 예외사항이 아니면 
#원칙은 컬럼명 그냥 삭제하고 values만 써서 자료를 연속으로 넣어주면 된다.(실제 사용은 벨류스만 쓰더라)
insert into `highschool_students`
values ('TB0004', '혜정', 1, '5반', '여자', 25, '2024-03-02');

select * from highschool_students;