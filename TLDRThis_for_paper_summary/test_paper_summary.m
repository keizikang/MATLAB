rapidapi_key = 'none of your business';

url = "https://tldrthis.p.rapidapi.com/v1/model/abstractive/summarize-url/";

payload = struct(...
    "url", "https://arxiv.org/pdf/2210.02587.pdf", ... % 주소
    "min_length", 100, ... % 최소 길이
    "max_length", 300, ... % 최대 길이
    "is_detailed", false ... % True: 한 문장, False: 여러 문장
);

options = weboptions(...
    'Timeout', 30, ...
    'MediaType', 'application/json', ...
    'HeaderFields', {...
    'content-type','application/json'; 
    'X-RapidAPI-Key', rapidapi_key;
    'X-RapidAPI-Host', 'tldrthis.p.rapidapi.com'});
response = webwrite(url, jsonencode(payload), options);
