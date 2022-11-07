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
fplot(@(x) exp(x)-1, [-1, 1], 'r', linewidth=3)
fplot(@(x) x.^3, [-1, 1], 'g', linewidth=3)
fplot(@(x) tan(x), [-1, 1], 'b', linewidth=3)

set(gca, XAxisLocation='origin', YAxisLocation='origin')
```

