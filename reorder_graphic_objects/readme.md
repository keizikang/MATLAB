# 그래픽 객체의 순서 바꾸기

### Axes 상 그래픽 객체의 순서를 바꿀 수 있습니다.
* 아래의 결과는 모두 R2022a 기준입니다.
* 참고한 곳들
  * https://stackoverflow.com/questions/7674700/how-to-change-the-order-of-lines-in-a-matlab-figure
  * https://www.mathworks.com/help/matlab/ref/uistack.html
  
* 작성자: [게으른](https://github.com/keizikang)

---

### 1. 테스트용 그래프 그리기

* 적당히 겹쳐있는 fplot 3개를 그립니다.

```matlab
figure, hold on,
fplot(@(x) 1*x, [-1, 1], 'r', linewidth=3)
fplot(@(x) 2*x, [-1, 1], 'g', linewidth=3)
fplot(@(x) 3*x, [-1, 1], 'b', linewidth=3)

set(gca, XAxisLocation='origin', YAxisLocation='origin')
```

![](./prepared_figure.png)

* 그래프를 그린 순서대로 올라갑니다.
* 가장 먼저 그린 빨간색이 맨 아래에, 그 위에 fplot의 순서대로 녹색, 파란색 선이 올라갑니다.
* gca의 Children 목록에도 이 순서대로 들어갑니다.

```matlab
>> children = get(gca, 'Children')
children = 
  3×1 FunctionLine array:

  FunctionLine
  FunctionLine
  FunctionLine
>> children.Function
ans =
  function_handle with value:
    @(x)3*x
ans =
  function_handle with value:
    @(x)2*x
ans =
  function_handle with value:
    @(x)x
```

* uistack()을 이용하면 이 라인들의 순서를 바꿀 수 있습니다.
* 
