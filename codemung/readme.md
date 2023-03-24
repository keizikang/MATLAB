# 불멍을 하고 싶은데 불이 없다?
# 이젠 코드멍이다!
### 만든이: humming_stereo님
### (팁: 인터스텔라 OST 중 [STAY](https://www.youtube.com/watch?v=j23SO29LNWE)를 들으며 보면 좋습니다.)

![](https://github.com/keizikang/MATLAB/blob/main/codemung/codemung.gif?raw=true)


```matlab
clc; clear; close all;

a = {'\\','|','/','ㅡ'};
tick = 1;
ii=0;
while true
    clc;
    fprintf(['Loading....',a{rem(ii,4)+1},'\n'])
    ii = ii+1;
    pause(tick)
end
```
