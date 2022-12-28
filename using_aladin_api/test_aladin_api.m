%% 상품 검색 API

key = 'ttbkey';
url = "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx";

data = webread(url, ...
    ttbkey = key, ...
    Query = "matlab", ... % 검색어: matlab
    QueryType = "Title",  ... % 제목으로 검색
    MaxResults = 20, ... % 최대 20개
    Sort = "SalesPoint", ... % 판매량으로 정렬
    CategoryId = 2735, ... % 분야: 국내도서 > 컴퓨터/모바일 > 컴퓨터 공학 > 전산수학(SPSS/MATLAB)
    outofStockfilter = 1, ... % 품절/절판 제외
    output = "js", ... % 출력형식: json
    Version = 20131101); % API 버전

list = data.item; % 도서 목록
titles = cellfun(@(s) s.title, list, 'UniformOutput', false); % 제목만 추출

%% 상품 목록 API

key = 'ttbkey';
url = "http://www.aladin.co.kr/ttb/api/ItemList.aspx";

data = webread(url, ...
    ttbkey = key, ...
    QueryType = "ItemNewAll", ... % 신간 전체
    SerachTarget = "Book", ... % 조회대상: 책
    MaxResults = 20, ... % 최대 20개
    CategoryId = 6734, ... % 분야: 국내도서 > 컴퓨터/모바일 > 프로그래밍 언어 > 파이썬
    outofStockfilter = 1, ... % 품절/절판 제외
    output = "js", ... % 출력형식: json
    Version = 20131101); % API 버전

list = data.item;
titles = cellfun(@(c) c.title, list, 'UniformOutput', false); % 제목만 추출

%% 상품 조회 API

key = 'ttbkey';
url = "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx";

data = webread(url, ...
    ttbkey = key, ...
    ItemId = "9791156644828", ... % 제품 고유번호, ISBN13을 권장
    output = "js", ... % 출력형식: json
    Version = 20131101); % API 버전
