#db접속하는 함수 모듈
from sqlalchemy import create_engine
from exdbinfo import db, dbtype, user, pw, host, database
import pymysql
import time

pymysql.install_as_MySQLdb()

def db_connect():
    engine = create_engine("%s+%s://%s:%s@%s/%s" % (db, dbtype, user, pw, host, database))  #컴파일 과정에서 인식이 안되는 것 같다. 다 서식 지정자로 바꿈 -> 오직 이것만 성공
    conn = engine.connect()
    return conn



# DB에 접속해서 저장하는 
#tp_db라는 함수만 불러오면 사용가능
def exi_to_db(table_name, date, df):
    conn = db_connect()
    df.to_sql(table_name, con=conn, if_exists='append', index=False) # today[:7]
    conn.close()
    
    return print(f"{table_name}_{date}, {'저장완료':<30s}", end="\r")