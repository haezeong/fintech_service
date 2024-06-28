use world;
show tables;
desc city;
desc country;
desc countrylanguage;

select id, name from city;
select * from city;
# 순서 바꾸고 싶을때는 직접 컬럼명 바꿔서 적어주면됨
# 그게 아니면 all =*
#프롬에 원래 테이블명만 들어가지만, 데이터베이스 쩜 테이블하면 조회가능
select * from mywork.highschool_students;

#where
select * from city where countrycode ='KOR';
select * from city where countrycode ='KOR'
and district like 'k%';
select * from city where countrycode ='KOR'
and district like '%k';
select * from city where countrycode ='KOR'
and district like '%ong%';

#in 연산자 활용한 쿼리 작성
# district 서울, 경기 in 사용
select * from city 
where countrycode ='KOR'
and district in ('seoul','kyonggi');
#컨트리 테이블에서 인구가 일억 초과인 나라를 찾아보시오 
select * from country where Population > 100000000;
#우리나라 인구 찾기
select * from country where name = 'south korea';
#우리나라 인구와 비슷한 나라 찾기 4천오백만보다 크거나 같고 오천오백만보다 작거나 같은 
select * from country where population between 45000000 and 55000000;


#박스 오피스 데이터 조회 
use mywork;
desc box_office;
select * from box_office limit 5;

select rep_country from box_office;
#칼럼의 유일값을 찾을대는 distinct 테이블 해주면 여러개 값중에서 유일값만 보여줌
select distinct rep_country from box_office;

#
select * from box_office 
where release_date between '2018-01-01' and '2018-12-31' 
and rep_country = '한국';

# 2019년에 개봉한 영화중에 관객이 천만 이상인 영화
select * from box_office 
where release_date between '2019-01-01' and '2019-12-31' 
and audience_num >= 1000000;

#order by로 정렬하기
#world country 테이블에서 인구가 1억을 초과하는 나라를 추출하고
#인구순으로 내림차순 정렬
use world;
select * from world.country
where Population >100000000
order by Population desc;

# 정렬을 두개 컬럼을 기준으로 하기
# country 테이블에서 인구수가 오천만명 이상인 나라를 찾아서 
# continent, region을 기준으로 오름차순 정렬 
# asc, desc 지정 안했을 때 옵션은 오름차순으로 설정된다
select * from world.country
where Population >=50000000
order by Continent, region;

select * from world.country
where Population >=50000000
order by Continent desc, region asc;
