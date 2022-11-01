# mat 파일의 내용 수정하기

### mat 파일을 load 하지 않고 수정할 수 있습니다.
* 아래의 결과는 모두 R2022a 기준입니다.
* 참고한 곳들
  *   https://www.mathworks.com/help/matlab/ref/matlab.io.matfile.html
  *   https://www.mathworks.com/help/matlab/import_export/load-parts-of-variables-from-mat-files.html
  *   https://www.mathworks.com/matlabcentral/answers/254048-how-can-i-delete-variables-in-my-mat-file-without-loading-them-into-matlab-7-2-r2006a
* 작성자: [게으른](https://github.com/keizikang)
* 도움 주신 분: [Chopthal](https://chopthal.github.io/)

---
### 목차

1. [데이터 준비](#1-데이터-준비)
2. [MatFile 객체 만들기](#2-matfile-객체-만들기)
3. [mat 파일에서 변수 가져오기](#3-mat-파일에서-변수-가져오기)
4. [mat 파일에 변수 추가하기](#4-mat-파일에-변수-추가하기)
5. [mat 파일 내 행렬의 일부만 가져오거나 변경하기](#5-mat-파일-내-행렬의-일부만-가져오거나-변경하기)
6. [MatFile을 입력으로 받는 함수들](#6-MatFile을-입력으로-받는-함수들)
7. [mat 파일에서 변수 삭제하기 + 변수명 변경하기](#7-mat-파일에서-변수-삭제하기--변수명-변경하기)
8. [팁](#8-팁)

---

### 1. 데이터 준비
* 시간 비교를 위해, 일부러 큰 데이터를 만들어서 mat 파일로 저장해봅니다.

```matlab
clear

load mri
D = squeeze(D);
D = imresize3(D, 10);
save('mri_big.mat');
```

* 기준 시간을 정하기 위해 load + save에 걸리는 시간 측정해봅니다.

```matlab
tic
load('mri_big.mat'); toc % 0.9초
save('mri_big.mat'); toc % 5.9초
```

---

### 2. MatFile 객체 만들기

* matfile()은 mat 파일과 연결되어 있는 matlab.io.MatFile 객체를 반환합니다.
* 실제로 데이터를 메모리에 로드하지는 않습니다.

```matlab
m = matfile('mri_big.mat');
```

---

### 3. mat 파일에서 변수 가져오기
* whos(m)를 통해 m이 가리키는 파일에 어떤 변수들이 들어있는지 볼 수 있습니다.
```
>> whos(m)
  Name         Size                      Bytes  Class     Attributes

  D         1280x1280x270            442368000  uint8               
  map         89x3                        2136  double              
  siz          1x3                          24  double              
```

* mri_big.mat에서 siz 변수만 꺼내고 싶다면?
```matlab
tic
siz = m.siz;
toc % 0.003초

tic
D = m.D;
toc % 0.9초
```

* 사실 일부 변수만 불러오는 건 load로도 빠르게 가능합니다.
```matlab
tic
load('mri_big.mat', 'siz');
toc % 0.002초
```

---

### 4. mat 파일에 변수 추가하기
* mat 파일을 수정하려면 쓰기 권한으로 열어야 합니다.

```matlab
m = matfile('mri_big.mat', Writable=true);
```

* 이미 열어둔 객체를 바꾸고 싶지 않다면 아래 방법도 가능합니다.
```matlab
m.Properties.Writable = true
```

* mri.mat를 로드해서 변수 D를 D_original이라는 이름으로 mri_big.mat에 추가해보겠습니다.
```matlab
load mri
tic
m.D_original = D;
toc % 0.01초 (load-save는 5.9초였음)
```

* 잘 들어갔나 확인해봅니다.
```
>> whos(m)
  Name               Size                      Bytes  Class     Attributes

  D               1280x1280x270            442368000  uint8               
  D_original       128x128x1x27               442368  uint8               
  map               89x3                        2136  double              
  siz                1x3                          24  double              
```

---


### 5. mat 파일 내 행렬의 일부만 가져오거나 변경하기

* 인덱싱으로 mat 파일 내 행렬의 일부만 가져올 수 있습니다.
* 단, 사전 작업이 한 가지 필요합니다.
```matlab
top_slice = m.D(:, :, 1);
```
* 라고 쓰면 Warning이 뜹니다.
```
Warning: The file
'D:\mri_big.mat'
was saved in a format that does not support partial
loading. Temporarily loading variable 'D' into memory.
To use partial loading efficiently, save MAT-files
with the -v7.3 flag. 
> In matlab.io/MatFile/inefficientPartialLoad (line 145)
In indexing (line 471) 
```

* mat 파일을 저장할 때 -v7.3 옵션을 사용해야 matfile()을 이용한 인덱싱이 가능합니다.
* 이 옵션 없이 저장한 mat 파일에서 변수 일부만 인덱싱으로 가져오면 변수 전체가 로드됩니다.
* -v7.3으로 다시 저장해봅니다.
```matlab
clear
load('mri_big.mat');
save('mri_big.mat', '-v7.3');
```

* D의 첫 번째 slice만 가져와보겠습니다.
```matlab
tic
m = matfile('mri_big.mat', Writable=true);
top_slice = m.D(:, :, 1);
toc % 0.8초
```

* load가 0.9초인 것에 비하면 큰 차이는 아니네요.

* 인덱싱으로 mat 파일 내 행렬의 일부를 수정할 수도 있습니다.

```matlab
tic
m.siz(1, 1:3) = [1280, 1280, 270];
toc % 0.02초
```
* 주의할 것이 몇 가지 있습니다.
  * 벡터이더라도 인덱스는 두 개 다 써줘야 합니다. `m.siz(1:3)`은 허용되지 않습니다.
  * end 키워드를 쓰지 않는 것이 좋습니다. end가 어디인지 모르므로 전체를 다 불러오게 됩니다.

* size() 함수에 MatFile 객체를 넣으면 end 문제를 해결할 수 있습니다.
```matlab
m.siz(1, 1:3) = size(m, 'D');
```

* 아래는 D의 첫 번째 slice를 0으로 만드는 코드입니다.
```matlab
sizDx = m.siz(1, 1);
sizDy = m.siz(1, 2);
tic;
m.D(1:sizDx, 1:sizDy, 1) = uint8(zeros(sizDx, sizDy));
toc % 3.5초
```

---

### 6. MatFile을 입력으로 받는 함수들

* `who(MatFile)`: MatFile에 저장된 변수 목록을 보여줍니다.
* `whos(MatFile)`: MatFile에 저장된 변수 목록, 크기, 타입을 모두 보여줍니다.
* `size(MatFile, variable)`: MatFile에 저장된 변수 variable의 크기를 보여줍니다.

---

### 7. mat 파일에서 변수 삭제하기 + 변수명 변경하기

* mat 파일 내 변수 삭제는 매트랩 코드만으로는 불가능합니다.
* .c 파일을 만들어서 MEX를 사용하는 방법은 가능합니다.
* 자세한 내용은 [요기](https://tinyurl.com/26356fdm)를 확인해주세요.
* 폴더에도 [파일](https://github.com/meticulousdev/MATLAB/blob/main/to_edit_matfile_using_matfile/rmvarMatFileMEX.c)을 올려두었습니다. 사용법도 코드에 간단히 적혀 있습니다. 그대로 따라하면 됩니다. 어렵지 않아요.
* 이 방법이 맘에 들지 않고, 그냥 파일 크기만 줄이고 싶은 거라면 삭제하고 싶은 변수에 빈 행렬을 덮어쓰는 방법도 가능합니다.
* mat 파일 내 변수명 변경 역시 매트랩 코드만으로는 불가능합니다.
* 변수 삭제를 응용하면 가능합니다.

---

### 8. 팁

* 파일 읽고 쓰는 횟수를 줄여라.
  * matfile도 어쨌든 파일 접근이므로 읽고 쓰는 데에 시간이 걸립니다.
  * 특히 큰 변수는 시간 많이 걸립니다. 단지 load/save보다 빠를 뿐입니다.
  * 파일을 읽고 쓰는 횟수를 줄이는 것이 좋습니다.

```matlab
% 이렇게 쓰지 말고
sizDx = m.siz(1, 1);
sizDy = m.siz(1, 2);
for row = 1:sizDx
    m.D(row,  :) = m.D(row, :)/2; % 파일 쓰기를 sizDx번 반복
end
```
```matlab
% 이렇게 쓰세요
m.D = m.D/2;
```

* size 활용법
  * MatFile.varname의 형태를 쓰면 무조건 변수 전체를 불러옵니다.
```matlab
siz = size(m.D); % 이렇게 쓰지 말고
```  
```matlab
siz = size(m, 'D'); % 이렇게 쓰세요
```

[처음으로](#mat-파일의-내용-수정하기)
