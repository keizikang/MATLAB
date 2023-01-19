rapidapi_key = "none"
naver_client_id = "of"
naver_client_secret = "your business"

import requests
from pprint import pprint

url = "https://tldrthis.p.rapidapi.com/v1/model/abstractive/summarize-url/"

payload = {
    "url": "https://arxiv.org/pdf/2210.02587.pdf", # 주소
    "min_length": 100, # 최소 길이
    "max_length": 300, # 최대 길이
    "is_detailed": False # True: 한 문장, False: 여러 문장
}

headers = {
    "content-type": "application/json",
    "X-RapidAPI-Key": rapidapi_key,
    "X-RapidAPI-Host": "tldrthis.p.rapidapi.com"
}

response = requests.request("POST", url, json=payload, headers=headers)
summary = response.json()['summary'][0].strip()
pprint(summary)

url = "https://openapi.naver.com/v1/papago/n2mt"

payload = {
    "source": "en",
    "target": "ko",
    "text": summary,
}

headers = {
    "content-type": "application/json",
    "X-Naver-Client-Id": naver_client_id,
    "X-Naver-Client-Secret": naver_client_secret,
}

response = requests.request("POST", url, json=payload, headers=headers)

pprint(response.json())
