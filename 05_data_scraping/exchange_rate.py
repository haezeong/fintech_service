from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from bs4 import BeautifulSoup as bs
from datetime import date
import pandas as pd
import dbio
import time


today =str(date.today())
#위에 있는거 합쳐서 한번에
#크롬 옵션즈에 정보를 담아 사람인 것 처럼 만들기
options = webdriver.ChromeOptions()
# options.add_experimental_option("excludeSwitches", ['enable-logging'])
# options.add_argument("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36")
# options.add_argument('lang=ko_KR')
options.add_argument('--headless')
options.add_argument('--no-sandbox')
options.add_argument('--disable-dev-shm-usage')


#크롬 웹브라우저 드라이버 자동 다운로드
driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()), options= options)
driver.set_window_size(1920, 1080) # 웹브라우저 해상도 조절
driver.get("https://www.kebhana.com/cms/rate/index.do?contentUrl=/cms/rate/wpfxd651_01i.do#//HanaBank")
# 웹 요소가 나타날 때까지 최대 10초 동안 기다립니다.
wait = WebDriverWait(driver, 10)

#날짜 변경
# search_box = driver.find_element(By.CSS_SELECTOR, "#tmpInqStrDt") # 얘는 id이므로 유일함 무조건 저거 하나만 쳐도 나옴
search_box = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, '#tmpInqStrDt')))
search_box.clear()
search_box.send_keys(today+Keys.ENTER)

#조회하기 버튼
search_button = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "#HANA_CONTENTS_DIV > div.btnBoxCenter > a")))
search_button.click()

#환율 정보 테이블이 뜰 때까지 기다림
exchange_rate_table = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, '#searchContentDiv > div.printdiv > table')))


page_html = driver.page_source
df = pd.read_html(page_html)[1]
df['date'] = today
cols = ('통화', '현찰사실때환율', '현찰살때Spread', '현찰팔때환율', '현찰팔때Spread', '송금보낼때', '송금받을때', 'T/C살때', '외화수표팔때', '매매기준율', '환가_료율', '미화환산율', 'date')
sorted_cols = ('date','통화', '현찰사실때환율', '현찰살때Spread', '현찰팔때환율', '현찰팔때Spread', '송금보낼때', '송금받을때', 'T/C살때', '외화수표팔때', '매매기준율', '환가_료율', '미화환산율')
df.columns = cols
df = df[[*sorted_cols]]


#db에 저장
dbio.exi_to_db("exchange_rate", today, df)