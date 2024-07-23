import pandas as pd
import requests
import time
from dotenv import load_dotenv
import os 

#
load_dotenv()

def naver_search2():
    service = input('''검색 서비스 번호를 입력하세요:
    1 블로그
    2 책
    3 뉴스
    4 전문자료
    ''')

    query= input("검색어를 입력하세요: ")
    
    if service =='1':
        service=='blog'
    elif service =='2':
        service=='book'
    elif service =='3':
        service=='news'
    elif service =='4':
        service=='doc'

    book_lists = []
    page = 1
    start = 1
    while True:
        client_id = os.getenv('client_id') # 네이버 api에 접속 가능한 id 
        client_secret = os.getenv('client_secret')      # 네이버 api에 접속 가능한 pw 
        url = f"https://openapi.naver.com/v1/search/{service}.json"
        payload = {'query': '핀테크', 'display' :10, 'start':1, 'sort':'sim'}
        headers = {"X-Naver-Client-Id" : client_id ,"X-Naver-Client-Secret" : client_secret }
 
        try:
        
            r= requests.get(url, params= payload, headers =headers)
            print(r, url)
            print(r.status_code)
            
            if(rescode==200):
                data = r.json()
                book_lists.append(data)
                total_page = data['total'] // 10 + 1

            else:
                print("Error Code:" + rescode)
                break

            if page < total_page:
                page += 1
                if start != 991:
                    start += 10
                elif start == 991:
                    start += 9
                print(f"{page:03d}/{total_page:03d}, start: {start} 추출중", end="\r")
            else:
                break
            time.sleep(0.5)
        except Exception as e:
            print(e)
            break


    print(len(book_lists))
    result = pd.DataFrame()
    for book_list in book_lists:
        temp = pd.json_normalize(book_list['items'])
        result = pd.concat([result, temp])
    result
    result.to_csv(f"naver_book_api_fintech_{query}_result.csv", encoding="utf-8")