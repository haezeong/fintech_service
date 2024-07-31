#순차적 실행
import os
import pandas as pd
import requests
from bs4 import BeautifulSoup as bs
from datetime import date
from dbenv import db, dbtype, id, pw, host, database
from sqlalchemy import create_engine, text
import pymysql
import time

pymysql.install_as_MySQLdb()


def str2int(x):
    x = int(x.replace(",", ""))
    return x

#겹치는 코드 빼줘서 불러오도록 만들어줌
def db_connect():
    engine = create_engine("%s+%s://%s:%s@%s/%s" % (db, dbtype, id, pw, host, database))  #컴파일 과정에서 인식이 안되는 것 같다. 다 서식 지정자로 바꿈 -> 오직 이것만 성공
    conn = engine.connect()
    return conn



# DB에 접속해서 저장하는 함수
def stock_info_to_db(idx, code, df):
    today = str(date.today()).replace("-","_")
    conn = db_connect()
    df.to_sql(f"{today[:7]}_stock_price_info_test", con=conn, if_exists='append', index=False)
    conn.close()
    
    return print(f"{today}, {idx}, {code}, {'저장완료':<30s}", end="\r")



#함수를 정의만하고 실행을 하지 않아서 결과가 아무것도 뜨지 않는다
#함수 호출 전까지 실행하지 않는다
def stock_info_scraping():
    # mysql에서 테이블 불러오기 
    conn = db_connect()
    data = pd.read_sql('2024_07_29_stock_company_info2', con=conn)
    conn.close()
        
    errors = {}
    for idx, (company, code) in enumerate(zip(data['회사명'], data['종목코드'])):
        stock_price_detail = {}
        url = f"https://finance.naver.com/item/main.naver?code={code}"   
        try:
            r = requests.get(url)
            print(r.status_code, f"{idx+1}/{len(data['종목코드'])} 수집중                    ", end="\r")
            soup = bs(r.text, 'lxml')
            # 가격
            price = int((soup.select_one(".today").text).strip("\n").split("\n")[1].replace(",", ""))
            # 변동금액
            price_chage = int((soup.select_one(".today").text).strip("\n").split("\n")[9].replace(",", ""))
            # 변화율
            rate_of_chage = float(((soup.select_one(".today").text).strip("\n").split("\n")[13]+(soup.select_one(".today").text).strip("\n").split("\n")[15]).replace("%",""))
            stock_price_detail.setdefault('수집일', []).append(str(date.today()))
            stock_price_detail.setdefault('회사명', []).append(company)
            stock_price_detail.setdefault('종목코드', []).append(code)
            stock_price_detail.setdefault('현재가', []).append(price)
            stock_price_detail.setdefault('변동금액', []).append(price_chage)
            stock_price_detail.setdefault('변화율', []).append(rate_of_chage)
            table = soup.select_one(".no_info")
            for tr in table.select("tr"):
                for td in tr.select('td'):
                    stock_price_detail.setdefault(td.select_one('span').text, []).append(str2int(td.select_one("span.blind").text))
            df = pd.DataFrame(stock_price_detail)
            stock_info_to_db(idx, code, df)  #데이터 추출
            time.sleep(5)
        except Exception as e:
            print(e)
            print(r.status_code, f"{idx+1}/{len(data['종목코드'])} 수집중 에러", end="\r")
            errors.setdefault("에러", []).append(code)
 
    return print(f"{str(date.today())} 주식 정보 수집 완료")      

#.py는 모듈이 될 수도 있다 -모듈로 만들경우 - 직접 실행해도 실행되지 않게
# if __name__ == "__main__":
#     pass
            
if __name__ == "__main__":   #진입
    stock_info_scraping()   #실행
    
     
    
#불러와서 실행하는 용도
