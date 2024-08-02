import os
import request
import sys
import pandas as pd
from datetime import date
import dbenv3
import time

news_lists = []
page = 1
start = 1
dvenv3()

while True:
    client_id = os.getenv('client_id') # 네이버 api에 접속 가능한 id 
    client_secret = os.getenv('client_secret')      # 네이버 api에 접속 가능한 pw 
    url = f"https://openapi.naver.com/v1/search/{service}.json"
    payload = {'query': '핀테크', 'display' :10, 'start':1, 'sort':'sim'}
    headers = {"X-Naver-Client-Id" : client_id ,"X-Naver-Client-Secret" : client_secret }

    try:
    
        r= requests.get(url, params= payload, headers =headers)
        
        if(r.status_code==200):
            data = r.json()
            book_lists.append(data)
            total_page = data['total'] // 10 + 1
            if total_page > 100:
                total_page = 100

        else:
            print("Error Code:" + r.status_code)
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


print(len(news_lists))
result = pd.DataFrame()
for news in news_lists:
    temp = pd.json_normalize(news['items'])
    result = pd.concat([result, temp])
result