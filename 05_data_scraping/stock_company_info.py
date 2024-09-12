
import pandas as pd
import requests
from bs4 import BeautifulSoup as bs
from datetime import date
from sqlalchemy import create_engine, text
import pymysql
import time

pymysql.install_as_MySQLdb()

# DB 연결 설정
db = "mysql"
dbtype = "pymysql"
user = "root"
pw = "1234"
host = "127.0.0.1"
port = "3306"
database = "korean_stock"


    
# DB 연결 함수
def db_connect(db_name=None):
    
    if db_name:
        engine = create_engine(f'{db}+{dbtype}://{user}:{pw}@{host}:{port}/{db_name}')
    else:
        engine = create_engine(f"{db}+{dbtype}://{user}:{pw}@{host}:{port}")
    conn = engine.connect()
    return conn



def create_database_if_not_exists(db_name):
    # 기본 MySQL 연결 (특정 DB 없이 연결)
    conn = db_connect()

    #korea_stock 데이터베이스가 존재하는지 확인하는 쿼리
    check_db_query = f"SHOW DATABASES LIKE '{db_name}'"

    db_exists = conn.execute(text(check_db_query)).fetchone()

    if not db_exists:
        # 데이터베이스가 없으면 생성
        print(f"데이터베이스 '{db_name}'가 없습니다. 새로 생성합니다.")
        create_db_query = f"CREATE DATABASE {db_name}"
        conn.execute(text(create_db_query))
    else:
        print(f"데이터베이스 '{db_name}'가 이미 존재합니다.")

    conn.close()
    
    
# 주식 정보를 DB에 저장하는 함수
def save_to_db(df, db_name="korean_stock"):
    today = str(date.today()).replace("-", "_")
    create_database_if_not_exists(db_name)
    conn = db_connect(db_name)
    df.to_sql("company_info", con=conn, if_exists='replace', index=False)
    conn.close()
    print("데이터 저장 완료", end="\r")
    
    

# 주식 정보 스크래핑 함수
def stock_info_scraping():
    page = 1
    page_size = 100
    final_result_df = pd.DataFrame()
    while True:
        url = "https://kind.krx.co.kr/corpgeneral/corpList.do"
        payload = dict(method='searchCorpList',pageIndex=page, currentPageSize=page_size,orderMode=3,orderStat='D',searchType=13, fiscalYearEnd='all', location='all')
        r = requests.get(url, params=payload)
        print(r.status_code, end="\r")
        soup = bs(r.text, 'lxml')
        total_items = int(soup.select_one(".info.type-00 > em").text.replace(",", ""))
        total_pages = total_items // page_size + 1
        print(f"{page}/{total_pages} 수집중", end="\r")
        keys = soup.select_one("table.list.type-00.tmt30")['summary'].split(", ")  
        result = {}
        for tr in soup.select('tr'):
            for idx, (key, td) in enumerate(zip(keys, tr.select('td'))):
                if idx == 0:
                    kinds = [img['alt'].strip() for img in td.select('img')]   # 1번째 증권 종류, 회사이름
                    kind = ", ".join(kinds)
                    code = td.select_one('a')['onclick'].split("'")[1]+"0" # 종목코드 추출
                    result.setdefault('증권종류', []).append(kind) # 증권종류 저장
                    result.setdefault(key, []).append(td.text)   # 회사이름 저장
                    result.setdefault('종목코드', []).append(code)
                elif idx == 6:
                    home_link = td.select_one('a')['href'] if td.string == None else ""
                    result.setdefault(key, []).append(home_link)
                else:
                    result.setdefault(key, []).append(td.text)
        result_df = pd.DataFrame(result)
        final_result_df = pd.concat([final_result_df, result_df])
            
        if page < total_pages:
            page += 1
            time.sleep(5)
        else:
            break
    
    # 최종 데이터프레임 저장
    save_to_db(final_result_df)

# 메인 함수 실행
if __name__ == "__main__":
    stock_info_scraping()
