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



#연습문제1 : passenger, ticket, survived 테이블을 조인하고 Survived가 1인 사람들만 찾아서 Name, Age, Sex, Pclass, survived 컬럼을 출력하시오.
select p.Name, p.Age, p.Sex, t.Pclass, s.Survived from passenger as p
inner join ticket as t
on p.PassengerId = t.PassengerId
inner join survived as s
on p.PassengerId = s.PassengerId
where s.Survived =1;


#연습문제2 : 1의 결과를 10개만 출력하시오.
select p.Name, p.Age, p.Sex, t.Pclass, s.Survived from passenger as p
inner join ticket as t
on p.PassengerId = t.PassengerId
inner join survived as s
on p.PassengerId = s.PassengerId
where s.Survived =1
limit 10;

select * from titanic.survived;
#연습문제3 :Passenger 테이블을 기준으로 ticket, survived 테이블을 LEFT JOIN 한 결과에서 성별이 여성이면서 Pclass가 1인 사람 중 생존자를 찾아 이름, 성별, Pclass를 표시하시오.
select p.Name, p.Sex, t.Pclass from passenger as p
left join ticket as t
on p.PassengerId = t.PassengerId
left join survived as s
on p.PassengerId = s.PassengerId
where sex = 'female' and Pclass =1 and survived =1;

#조인을 하고나면 하나의 테이블이 된다. 

#4. passenger, ticket, survived 테이블을 left join후
# 나이가 10세 이상 20세 이하 이면서
# Pclass 2인 사람 중
# 생존자를 표시하시오.
select * from passenger as p
left join ticket as t
on p.PassengerId = t.PassengerId
left join survived as s
on p.PassengerId = s.PassengerId
where Age between 10 and 20 and Pclass=2 and survives=1;

#5. passenger, ticket, survived 테이블을 left join후
# 성별이 여성 또는
# Pclass 1인 사람 중
# 생존자를 표시하시오.
select * from passenger as p
left join ticket as t
on p.PassengerId = t.PassengerId
left join survived as s
on p.PassengerId = s.PassengerId
where (sex = 'female' or Pclass =1) and survived =1;

#6. passenger, ticket, survived 테이블을 left join후
# 생존자 중에서 이름에 Nrs가 포함된 사람을 찾아
# 이름, Pclass, 나이, Parch, Survived를 표시하시오.
select Name, Pclass, Age, Parch, Survived from passenger as p
left join ticket as t
on p.PassengerId = t.PassengerId
left join survived as s
on p.PassengerId = s.PassengerId
where survived =1 and name Like '%Mrs%';

#7. passenger, ticket, survived 테이블을 left join후
# Pclass가 1, 2이고 Embarked가 s, c 인 사람중에서 
# 생존자를 찾아
# 이름, 성별, 나이를 표시하시오.
select Name, sex, Age from passenger as p
left join ticket as t
on p.PassengerId = t.PassengerId
left join survived as s
on p.PassengerId = s.PassengerId
where Pclass in (1,2) and Embarked in ('s','c') and survived =1;

# and, or
select * from ticket where Pclass=1 or Pclass=2 and Embarked ='c';
select * from ticket where (Pclass=1 or Pclass=2) and Embarked ='c';
select * from ticket where Pclass in (1,2) and Embarked ='c';

#8. passenger, ticket, survived 테이블을 left join후
#이름에 James가 들어간 사람중
#생존자를 찾아
#이름, 성별, 나이를 표시하고 
# 나이를 기준으로 내림차순 정렬하시오.
select Name, sex, Age from passenger as p
left join ticket as t
on p.PassengerId = t.PassengerId
left join survived as s
on p.PassengerId = s.PassengerId
where Name like '%James%' and survived =1
order by age Desc;

#9. passenger, ticket, survived 테이블을 inner join한 데이터에서
#성별별, 생존자의 숫자를 구하시오.
#생존자 숫자 결과는 별칭을 Total로 하시오.
select sex, count(survived) as Total from passenger as p
inner join ticket as t
on p.PassengerId = t.PassengerId
inner join survived as s
on p.PassengerId = s.PassengerId
where survived = 1 #생존자라는 조건 주의하기
group by sex ;

#10.passenger, ticket, survived 테이블을 inner join한 데이터에서
# 성별별, 생존자의 숫자, 생존자 나이의 평균을 구하시오. 
# 생존자 숫자 결과는 별칭을 Total로 하시오.
select sex, count(survived) as Total, avg(survived) from passenger as p
inner join ticket as t
on p.PassengerId = t.PassengerId
inner join survived as s
on p.PassengerId = s.PassengerId
where survived = 1
group by sex;

