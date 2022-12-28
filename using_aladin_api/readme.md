# 알라딘 API를 이용하여 도서 검색하기

* 우선 [API 키 발급 페이지](https://www.aladin.co.kr/ttb/wblog_manage.aspx)로 가서 인증키를 받아야 합니다.
  * 키 발급 시 URL 주소는 블로그 주소를 넣어도 됩니다.
* 발급받은 키를 아래 코드의 ttbkey 부분에 넣습니다.

```matlab
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
```

* 요청 url은 기본 url 뒤에 파라미터를 key=value의 형태로 추가하는 형태입니다.
* 각 key=value는 &로 구분합니다.
* 예:     'http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=[ttbkey]&Query=matlab&QueryType=Title&Sort=SalesPoint&CategoryId=2735&output=js&Version=20131101'
* 필수 파라미터
  * TTBKey: API 인증키
  * Query: 검색어
* 옵션 파라미터
  * QueryType: 검색어 종류 (Keyword/Title/Author/Publisher)
  * SearchTarget: 검색 대상 (Book(도서), Foreign(외국도서), Used(중고샵), eBook 등)
  * MaxResults: 출력 개수, 100이 최대
  * Sort: 정렬순서 (Accuracy(관련도)/PublishTime(출간일)/SalesPoint(판매량)/CustomerRating(고객평점) 등)
  * CategoryId: 도서분류 ([알라딘 도서분류표 엑셀](https://image.aladin.co.kr/img/files/aladin_Category_CID_20210927.xls))
    * 분류를 넣으면 노이즈를 줄일 수 있는 반면, 책마다 분류가 달라서 놏이는 경우도 생길 수 있음
  * output: 출력방법 (js/xml, js를 권장)
  * Version: API 버전 (20131101을 쓸 것)
  * outofStockfilter: 품절/절판 등 재고 없는 제품을 제외할 것인지? "1"이면 제외함
* 파라미터들은 [알라딘 Open API 매뉴얼](https://docs.google.com/document/d/1mX-WxuoGs8Hy-QalhHcvuV17n50uGI2Sg_GHofgiePE/edit)에서 확인하실 수 있습니다.
* 매트랩의 [webread](https://www.mathworks.com/help/matlab/ref/webread.html) 함수는 위 코드와 같이 Name = Value의 형태의 파라미터를 받아서, 알아서 하나의 url로 만들어줍니다.
  * webread 함수는 단 네 줄입니다. encodeInputs 함수가 url을 합쳐주는 역할을 합니다.
* output은 js(json)를 권장합니다. 매트랩에서 알아서 파싱을 해줍니다.
  * webread -> readContentFromWebService -> copyContentToByteArray -> decodeByteArray
* webread는 아래 형태의 구조체를 반환합니다.

```matlab
>> data
data = 
  struct with fields:

               version: '20131101'
                  logo: 'http://image.aladin.co.kr/img/header/2011/aladin_logo_new.gif'
                 title: '알라딘 검색결과 - matlab'
                  link: 'http://www.aladin.co.kr/search/wsearchresult.aspx?KeyTitle=matlab&amp;SearchTarget=book&amp;partner=openAPI'
               pubDate: 'Wed, 28 Dec 2022 05:43:25 GMT'
          totalResults: 31
            startIndex: 1
          itemsPerPage: 20
                 query: 'matlab'
      searchCategoryId: 2735
    searchCategoryName: '국내도서&gt;컴퓨터/모바일&gt;컴퓨터 공학&gt;전산수학(SPSS/MATLAB)'
                  item: {20×1 cell}
```

* 반환된 구조체의 item 필드에 책 목록이 셀 형태로 들어있습니다.
* 책마다 field가 다를 수 있습니다.

```matlab
>> data.item{1}
ans = 
  struct with fields:

                 title: '제대로 배우는 MATLAB & Simulink'
                  link: 'http://www.aladin.co.kr/shop/wproduct.aspx?ItemId=234784821&amp;partner=openAPI&amp;start=api'
                author: '방성완 (지은이)'
               pubDate: '2020-03-05'
           description: 'MATLAB의 기본 기능부터 핵심 기능까지 공학도에게 꼭 필요한 내용을 설명한 후 이를 전공 예제에 차근차근 적용할 수 있도록 구성된 책이다. 또한 Simulink까지 범위를 확장하여 주요 블록들의 기능을 소개한 후 이를 다시 전공 예제에 접목하여 설계할 수 있다.'
                  isbn: 'K452638508'
                isbn13: '9791156644828'
                itemId: 234784821
            priceSales: 29000
         priceStandard: 29000
              mallType: 'BOOK'
           stockStatus: ''
               mileage: 0
                 cover: 'https://image.aladin.co.kr/product/23478/48/coversum/k452638508_1.jpg'
            categoryId: 2735
          categoryName: '국내도서>컴퓨터/모바일>컴퓨터 공학>전산수학(SPSS/MATLAB)'
             publisher: '한빛아카데미(교재)'
            salesPoint: 1509
                 adult: 0
            fixedPrice: 1
    customerReviewRank: 0
               subInfo: [1×1 struct]
```

* 그 외에도 분야별 신간, 베스트셀러 등을 볼 수 있는 상품 리스트 API, 상품 하나만 조회하는 상품 조회 API, 중고상품 보유 매장 검색 API 등이 있습니다.
* 사용법은 위와 거의 같습니다.
* 자세한 내용은 [알라딘 Open API 매뉴얼](https://docs.google.com/document/d/1mX-WxuoGs8Hy-QalhHcvuV17n50uGI2Sg_GHofgiePE/edit)에서 확인할 수 있습니다.

---

* 참고한 곳들
  * [알라딘 OpenAPI 안내](https://www.aladin.co.kr/ttb/apiguide.aspx?Version=20131101)
  * [알라딘 OpenAPI](https://blog.aladin.co.kr/openapi/6695306)
  * [API 사용 예제](https://blog.aladin.co.kr/openapi/5353301) - python 코드도 있으나 deprecated로 보임
  * [상품 API 안내](https://blog.aladin.co.kr/openapi/category/29154402?communitytype=mypaper)
