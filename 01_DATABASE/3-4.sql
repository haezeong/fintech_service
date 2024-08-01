# sql 함수
# sql 함수 작동방법
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


