# 매트랩의 역사

## 1965년, Cleve Moler가 박사학위를 받음

* 논문 제목은 [Finite Difference Methods for the Eigenvalues of Laplace’s Operator](https://books.google.co.kr/books/about/Finite_Difference_Methods_for_the_Eigenv.html?id=0b4-AAAAIAAJ&redir_esc=y)
* 이 논문에서 다룬 L-shaped membrane이 현재 매스웍스 로고임


![](https://www.mathworks.com/company/newsletters/articles/the-origins-of-matlab/_jcr_content/mainParsys/image_5.adapt.full.medium.gif/1670561965825.gif)


## 1967년, 매트랩의 시초

* Cleve Moler가 one-time thesis advisor인 [George Forsythe](https://en.wikipedia.org/wiki/George_Forsythe)와 함께 선형대수 프로그래밍을 개발함
* 이것이 매트랩의 시초가 됨

## 1965~1970년, 행렬연산과 고유값 문제 풀이 과제

* [JK Wilkinson](https://en.wikipedia.org/wiki/James_H._Wilkinson)이 행렬연산과 고유값 문제 풀이를 위해 Algol 60으로 작성한 알고리즘 논문을 출간함
* 나중에 [책](https://link.springer.com/book/10.1007/978-3-642-86940-2)으로도 나옴
* 이 연구들이 나중에 매트랩 개발의 근간이 됨

## 1970년, EISPACK 시작

* Argonne National Laboratory(ANL)의 연구원들이 미국 국립과학재단(NSF)에 수학 소프트웨어의 생산, 시험 및 보급을 위한 방법론, 비용 및 리소스 탐색을 제안함
* 그렇게 만들어진게 EISPACK(matrix EIgenSystem PACKage)
* 고유값 문제를 푸는 Algol 코드를 포트란으로 번역한 것이었음

## 1971년, EISPACK 발표

* EISPACK의 첫 번째 버전이 발표됨

## 1975년, LINPACK 제작

* Jack Dongarra, Pete Stewart, Jim Bunch, Cleve Moler가 NSF에 다른 수학 소프트웨어를 제안함
* 이때 만들어진 것이 LINPACK(LINear equation PACKage)
* EISPACK과 다르게 처음부터 포트란으로 제작됨
* 44개의 서브루틴으로 구성되었고, 4개의 정밀도가 있었음

## 1979년, 첫 번째 MATLAB

* Cleve Moler는 뉴멕시코 대학에서 선형대수와 수치해석을 가르치고 있었음
* 학생들이 포트란 코드를 쓰지 않고 LINPACK과 EISPACK을 쓰면 좋겠다고 생각함
* 그래서 Niklaus Wirth의 [Algorithms + Data Structures = Program](https://en.wikipedia.org/wiki/Algorithms_%2B_Data_Structures_%3D_Programs)이라는 책을 읽고 프로그래밍 언어를 만드는 방법을 배웠음
* MATLAB은 그저 학생들 편하라고 시작한 토이 프로젝트였며, 인터랙이브한 행렬 계산기에 불과했음
* 포트란으로 만들었고 자료형은 행렬밖에 없었음
* 당연히 공식적인 외부 지원도 없었고 사업계획도 없었음


![](https://www.mathworks.com/company/newsletters/articles/a-brief-history-of-matlab/_jcr_content/mainParsys/image_0_copy.adapt.full.medium.jpg/1669738719908.jpg)
* 예약어와 함수는 다 합쳐서 총 71개
* 함수를 추가하려면 소스 코드에 포트란 서브루틴을 추가한 후 매트랩을 다시 컴파일 해야했음
* 그래프는 아래처럼 생겼음


![](https://www.mathworks.com/company/newsletters/articles/the-origins-of-matlab/_jcr_content/mainParsys/image_13.adapt.full.medium.gif/1469941529506.gif)

## 1980년, Jack Little과의 만남

* 스탠포드 대학원생이었던 Jack Little이 친구를 통해 매트랩을 보게 되고 개인 프로젝트에 적용함

## 1983년, MATLAB 상용화의 시작

* Jack Little이 매트랩의 상용화를 제안함
* 갓 나온 IBM PC는 매트랩이 겨우 돌아갈 수준이었지만, Little은 앞으로 컴퓨터가 더 발전할 거라고 예상함
* Little은 직장까지 그만두고 컴팩 PC를 사서 C로 매트랩을 만들어냈음

## 1984년, PC-MATLAB 발표

* Mathworks가 설립됨
* PC-MATLAB이 IEEE Conference on Decision and Control에서 데뷔를 했고 Unix 버전인 Pro-MATLAB이 1985년에 발표됨
![](https://www.mathworks.com/company/newsletters/articles/a-brief-history-of-matlab/_jcr_content/mainParsys/image_0_copy_copy.adapt.full.medium.jpg/1669738719921.jpg)
* 1980년대 말까지 수백 카피가 대학에 팔림

## 1987년, Signal Processing Toolbox, ODEs

* ODE는 매트랩의 상용화 이후로 꾸준히 중요한 주제였음
* ODE는 시뮬링크의 핵심 파트이기도 함

## 1992년, Sparse matrix, Simulink
* Sparse matrix는 1992년 MATLAB 4에 처음 소개됨 (sparse, full 함수)

## 1993년, Image Processing Toolbox, Symbolic Math Toolbox

## 1996년, Single Precision, Cell array, Structures
* 한동안 매트랩은 IEEE-754 double-precision floating point만 지원했음
* 1996년 MATLAB 5에서 Single Precision이 도입됨

## 1999년, Objects

## 2000년, Desktop, LAPACK(Linear Algebra PACKage)
* 데탑 버전이 발표됨

## 2004년, Integer data types, Functional handles, Parallel computing
* MATLAB 7에서는 uint8, uint16, uint32, int8, int16, int32, logical도 소개되었음

## 2008년, Objects improved
* OOP가 발전함

## 2010년, GPUs

## 2014년, New graphics system

## 2016년, Live Editor

## 2017년, Tall arrays and categorical arrays


## 참고한 곳들

https://www.mathworks.com/company/newsletters/articles/the-origins-of-matlab.html

https://www.mathworks.com/company/newsletters/articles/a-brief-history-of-matlab.html

https://www.thebatt.com/science-technology/matlab-creator-discusses-coding-platform-s-origin/article_bade58f4-0c39-11e6-a307-4ff3664adcd7.html

https://en.wikipedia.org/wiki/MATLAB

https://dl.acm.org/doi/pdf/10.1145/3386331

https://www.thebatt.com/science-technology/matlab-creator-discusses-coding-platform-s-origin/article_bade58f4-0c39-11e6-a307-4ff3664adcd7.html
