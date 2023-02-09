ccc

%% generate table
%
% 테이블을 만드는 방법은 여러 가지가 있지만
% 엑셀을 만들고 불러오는게 제일 편하다.

itzy = readtable('itzy.xlsx');
disp(itzy)

%% name indexing
%
% names, lastname 등은 variable이라고 부른다.
% 변수를 가리키는 variable과 이름이 같으니 헷갈리지 말자.
% table.varname의 형태로 각 variable에 접근할 수 있다.
% table.varname은 array를 반환한다.

disp('itzy.names')
disp(itzy.names)

disp('itzy.height')
disp(itzy.height)

%% numeric indexing
%
% 하지만 여전히 numeric indexing도 된다.
% table(m, n)은 n번째 variable의 m번째 값을 반환한다.
% 그런데 반환 자료형이 table이다. 주의하자.
% 물론 table(:, 1), table(2:4, 3:5)의 형태도 모두 가능하다.

disp('itzy(:, 2)')
disp(itzy(:,2))

disp('itzy(2:4, 3:end)')
disp(itzy(2:4, 3:end))

%% add a variable
%
% 변수를 추가하고 싶다면?
% struct에 field를 추가하는 것과 동일한 문법이다.
% 다만 원래 table의 크기와 호환되어야 한다.

disp('add MBTI')
itzy.MBTI = ["ESTJ", "ENFJ", "INTJ", "ISFJ", "ENFP"]';
disp(itzy)

%% add a variable in the middle
%
% 위 방식으로는 MBTI가 맨 끝에 추가된다.
% variable을 중간에 넣고 싶다면?
% addvars 함수에 After 또는 Before 옵션을 쓰면 된다.

disp('add bloodtype')
bloodtype = ["A", "AB", "B", "B", "A"]';
itzy = addvars(itzy, bloodtype, 'After', 'lastname');

disp(itzy)

%% reorder variables
% 
% variable의 순서를 바꿀 수 있다.
% 일반 array와 같은 방식으로 동작한다.

disp('reorder variables')
itzy = itzy(:, [1, 2, 4, 5, 6, 3]);

disp(itzy)

%% delete variables
%
% 방법1: table.varname = []
% 방법2: table(:, index) = []

disp('delete bloodtype and MBTI')
itzy(:,end) = [];
itzy.MBTI = [];

disp(itzy)

%% add or delete a row
%
% 추가: 일반 array와 같은 방식이되, cell이나 table을 대입해야 한다.
% 삭제: 일반 array와 같은 방식이다.

disp('add Gandalf as a new member')
itzy(end+1, :) = {'Gandalf', 'the Grey', 3019, 180};
disp(itzy)

disp('remove Gandalf')
itzy(end, :) = [];
disp(itzy)

%% conditional indexing

% names가 Yeji와 Yuna인 rows만으로 새로운 table 만들기
disp('a new table with only Yeji and Yuna')
names = ["Yeji", "Yuna"];
[~, idx] = ismember(names, itzy.names);
disp(itzy(idx, :))

% 키가 165 이상인 멤버만으로 새로운 table 만들기
disp('a new table of members with height>=165')
idx = (itzy.height>=165);
disp(itzy(idx, :))

%% sortrows
% 
% sortrows를 이용하면 특정 variable로 sort 할 수 있음

disp('sort by name')
itzy = sortrows(itzy, "names");
disp(itzy)