% 목차
%   1. 데이터 준비
%   2. MatFile 객체 만들기
%   3. mat 파일에서 변수 가져오기
%   4. mat 파일에 변수 추가하기
%   5. mat 파일 내 행렬의 일부만 가져오거나 변경하기
%   6. MatFile을 입력으로 받는 함수들
%   7. mat 파일에서 변수 삭제하기 + 변수명 변경하기
%   8. 팁
%
% 아래 결과는 모두 R2022a 기준임
% 
% 참고한 곳들
%   https://www.mathworks.com/help/matlab/ref/matlab.io.matfile.html
%   https://www.mathworks.com/help/matlab/import_export/load-parts-of-variables-from-mat-files.html

%% 1. 데이터 준비
% 일부러 큰 데이터를 만들어서 mat 파일로 저장 
% 나중에 시간 비교를 해보기 위함

clear

load mri
D = squeeze(D);

% 일부러 데이터를 크게 불려보겠음
D = imresize3(D, 10);
save('mri_big.mat');

% 기준 시간을 정하기 위해 load + save에 걸리는 시간 측정
tic
load('mri_big.mat'); toc
save('mri_big.mat'); toc

% load에 0.9초, save까지는 5.9초 정도가 소요됨

%% 2. MatFile 객체 만들기
% matfile()은 matlab.io.MatFile 객체를 반환함
% 이 객체는 mat 파일과 연결되어 있음
% 실제로 데이터를 메모리에 로드하지는 않음

m = matfile('mri_big.mat');

%% 3. mat 파일에서 변수 가져오기
% mri_big.mat에서 siz 변수만 꺼내고 싶을 때

whos(m) % m이 가리키는 파일에 어떤 변수들이 들어있는지 볼 수 있음

tic
siz = m.siz;
toc % 0.003초 소요됨

tic
D = m.D;
toc % 0.9초 소요됨

% 사실 일부 변수만 불러오는 건 load로도 빠르게 가능함

tic
load('mri_big.mat', 'siz');
toc % 0.0002초 소요됨

%% 4. mat 파일에 변수 추가하기

% mat 파일에 변수를 추가하거나 변경하려면 쓰기 권한으로 열어야 함
m = matfile('mri_big.mat', Writable=true);
% 이미 열어둔 객체를 바꾸고 싶지 않다면 아래 방법도 가능함
% m.Properties.Writable = true

% mri.mat를 로드해서 변수 D를 D_original이라는 이름으로 mri_big.mat에 추가
load mri
tic
m.D_original = D; % 0.01초 미만 소요 (load-save는 5.9초였음)
toc

% 잘 들어갔나 확인
whos(m)

%% 5. mat 파일 내 행렬의 일부만 가져오거나 변경하기

% 인덱싱으로 mat 파일 내 행렬의 일부만 가져올 수 있음
% 단, 사전 작업이 한 가지 필요한데 
top_slice = m.D(:, :, 1);
% 라고 쓰면 Warning이 뜸
% mat 파일을 저장할 때 -v7.3 옵션이 있어야 인덱싱이 가능
% 이 옵션 없이 저장한 mat 파일에서 변수 일부만 인덱싱으로 가져오려면
% 임시로 변수 전체를 불러와야 함

% -v7.3으로 다시 저장
clear
load('mri_big.mat');
save('mri_big.mat', '-v7.3');

% D의 첫 번째 slice만 가져오기
tic
m = matfile('mri_big.mat', Writable=true);
top_slice = m.D(:, :, 1);
toc % 0.8초 걸림 (load가 0.9초인 것에 비하면 큰 차이는 아님)

% 인덱싱으로 mat 파일 내 행렬의 일부를 수정할 수도 있음
tic
m.siz(1, 1:3) = [1280, 1280, 270];
toc % 0.02초
% 주의1. 벡터이더라도 인덱스는 두 개 다 써줘야 함
% 주의2. end 키워드를 쓰지 말 것 (end가 어디인지 모르므로 전체를 다 불러옴)
% 해결책: size() 함수에 MatFile 객체를 넣을 수 있음
m.siz(1, 1:3) = size(m, 'D');

sizDx = m.siz(1, 1);
sizDy = m.siz(1, 2);
tic;
m.D(1:sizDx, 1:sizDy, 1) = uint8(zeros(sizDx, sizDy));
toc % 3.5초

%% 6. MatFile을 입력으로 받는 함수들

% who(MatFile): MatFile에 저장된 변수 목록
% whos(MatFile): MatFile에 저장된 변수 목록, 크기, 타입
% size(MatFile, variable): MatFile에 저장된 변수 variable의 크기

%% 7. mat 파일에서 변수 삭제하기 + 변수명 변경하기

% 변수 삭제: 매트랩만으로는 불가능
% .c 파일을 만들어서 MEX를 사용하는 방법은 가능함
% 참고할 곳: https://tinyurl.com/26356fdm
% 이 방법이 맘에 들지 않고, 그냥 파일 크기만 줄이고 싶은 거라면
% 삭제하고 싶은 변수에 빈 행렬을 덮어쓰는 방법도 가능함

% 변수명 변경: 역시 매트랩만으로는 불가능
% 위 방법을 응용하면 가능함

%% 8. 팁

% 1. 파일 읽고 쓰는 횟수를 줄여라.
% - matfile도 어쨌든 파일 접근이므로 읽고 쓰는 데에 시간이 걸림
% - 특히 큰 변수는 시간 많이 걸림. 단지 load/save보다 빠를 뿐
% - 파일을 읽고 쓰는 횟수를 줄일 것
% 나쁜 예
sizDx = m.siz(1, 1);
sizDy = m.siz(1, 2);
for row = 1:sizDx
    m.D(row,  :) = m.D(row, :)/2; % 파일 쓰기를 sizDx번 반복
end
% 좋은 예
m.D = m.D/2;

% 2. size 활용법
% - MatFile.varname의 형태를 쓰면 무조건 변수 전체를 불러옴
% - size는 아래와 같이 쓸 것
% 나쁜 예
siz = size(m.D);
% 좋은 예
siz = size(m, 'D');
