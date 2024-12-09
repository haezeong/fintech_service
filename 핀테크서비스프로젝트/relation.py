import pandas as pd
import matplotlib.pyplot as plt
import pymysql

# 데이터베이스 연결 정보
db_config = {
    'host': '127.0.0.1',
    'port': 3306,
    'user': 'root',
    'password': '1234',
    'database': 'project',
    'charset': 'utf8mb4'
}

# 1. 데이터 로드
conn = pymysql.connect(**db_config)

# 쿼리 실행
stores_query = "SELECT store_id, price_range FROM stores;"
reviews_query = "SELECT store_id, taste FROM reviews;"

stores_df = pd.read_sql(stores_query, conn)
reviews_df = pd.read_sql(reviews_query, conn)

# MySQL 연결 종료
conn.close()

# 2. 데이터 전처리
# price_range를 숫자 형태로 변환
def parse_price_range(price):
    if price is None or pd.isna(price):  # NULL 값 처리
        return None
    price = price.replace('₩', '')  # '₩' 기호 제거
    if "1,000" in price and "10,000" in price:
        return 5000
    elif "10,000" in price and "20,000" in price:
        return 15000
    elif "20,000" in price and "30,000" in price:
        return 25000
    elif "30,000" in price:
        return 30000
    return None

stores_df['price_numeric'] = stores_df['price_range'].apply(parse_price_range)

# taste를 숫자 형태로 매핑
taste_mapping = {'긍정적': 1, '부정적': -1, '알 수 없음': 0}
reviews_df['taste_numeric'] = reviews_df['taste'].map(taste_mapping)

# stores와 reviews 데이터를 병합
merged_df = pd.merge(stores_df, reviews_df, on='store_id')

# 3. 평균 값 계산 (가격과 맛)
average_data = merged_df.groupby('store_id').agg(
    average_price=('price_numeric', 'mean'),
    average_taste=('taste_numeric', 'mean')
).reset_index()

# 4. 시각화
plt.figure(figsize=(10, 6))
plt.scatter(average_data['average_price'], average_data['average_taste'], alpha=0.7, color='blue')

# 축 및 제목 설정
plt.title('Price vs Taste', fontsize=16)
plt.xlabel('Average Price (₩)', fontsize=12)
plt.ylabel('Average Taste Score', fontsize=12)
plt.grid(True)
plt.show()
