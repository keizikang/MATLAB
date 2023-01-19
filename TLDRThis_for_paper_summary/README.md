# 논문 요약 및 번역해주는 인공지능

* [빵형의 영상](https://www.youtube.com/watch?v=1f_i0wUNKVY)을 보고 그대로 따라했습니다.
* 방법은 영상에 잘 설명되어 있으므로 여기에는 추가하지 않겠습니다.
* 타겟으로 한 [논문](https://arxiv.org/pdf/2210.02587.pdf)은 arXiv에 pdf가 올라와 있습니다.
* 아래는 파이썬 코드입니다.

https://github.com/meticulousdev/MATLAB/blob/281ab388a53bd2ea3f2a422ec4c376277360aee2/TLDRThis_for_paper_summary/test_paper_summary.py#L1-L43

* 매트랩으로도 가능한지 궁금해졌습니다.
* [알라딘 API](https://github.com/meticulousdev/MATLAB/tree/main/using_aladin_api)에서 얻은 자신감으로 그 기세를 이어가려고 했습니다만,
* 단순히 key=value의 형태로 이어붙이는 게 아니라는 걸 깨달았습니다.
* 웹은 문외한이라 검색어조차 몰라서 허둥대고 있었는데...
* 청포도님의 조언대로 [chapGPT](https://openai.com/blog/chatgpt/)에게 물어봤습니다. "Convert the python code below to matlab code"
* 에이 설마...라고 생각했는데 정말 바꿔주더군요.

![](https://github.com/meticulousdev/MATLAB/blob/main/TLDRThis_for_paper_summary/chapGPT_py_to_mat.gif)

* 심지어 POST를 날리고 싶으면 webwrite를 쓰라는 것, webwrite가 파이썬의 requests.request와 비슷하다는 것까지 알려줍니다. 조금 무섭습니다.
* 하지만 문법에 맞지 않았습니다. 약간 귀여워졌습니다. 그래도 충분히 힌트는 되었습니다.
* [여러](https://www.mathworks.com/help/matlab/ref/webwrite.html) [곳들을](https://www.mathworks.com/help/matlab/ref/weboptions.html) [참고하여](https://www.mathworks.com/matlabcentral/answers/486888-how-can-i-post-json-arguments-request-payload-using-matlab-s-webwrite) 코드를 수정했습니다.

https://github.com/meticulousdev/MATLAB/blob/281ab388a53bd2ea3f2a422ec4c376277360aee2/TLDRThis_for_paper_summary/test_paper_summary.m#L1-L19

* 주의할 점이 있습니다. Timeout을 충분히 길게 잡아주어야 합니다.
* Timeout 기본값은 5초인데, 논문 텍스트 분석이 5초 이상 걸리나 봅니다.
* 그것도 모르고 코드를 잘못 적은 줄 알고 한참 삽질했습니다.
* 도움 주신 **바이올린 소나타**님께 감사 말씀 드립니다.
* 참고로 저는 Too Many Requests로 잠시 밴 먹은 상태입니다(...)
