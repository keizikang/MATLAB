function number_baseball()

disp('머리 속으로 세 자리 숫자를 생각해두세요.')
disp('0으로 시작해도 ㄱㅊ.');
input('준비됐으면 엔터를 치세요.')

% 가능한 모든 세자리 숫자 목록
list = gen_all_nums();

invalid_judge = 0;
n_try = 0;
while true % 못 맞추는 동안
    if invalid_judge == 0
        guess = gen_guess(list);
    end
    fprintf('혹시... %s 이거? ', guess)
    n_try = n_try + 1;
    judge = input('판정을 내리세요: ', 's');
    if strcmp(judge, '3s')
        if n_try<=3
            fprintf('앗싸 %s번만에 맞췄다.\n', num2hangul(n_try))
        elseif n_try<=5
            fprintf('쩝... %s번만에 맞췄네.\n', num2hangul(n_try))
        else
            fprintf('에혀... 이게 뭐라고 %s번이나 걸리다니... \n', num2hangul(n_try))
        end
        break
    elseif ~ismember(judge, {'2s','1s2b','1s1b','1s','3b','2b','1b','out'})
        warning('제대로 다시 써라')
        invalid_judge = 1;
        n_try = n_try - 1;
        continue
    end
    if n_try == 3
        num2exclude = input('어렵다~ 빼도 되는 숫자 하나만 알려줘. :', 's');
        list = refine(repmat(num2exclude, 1, 3), list, 'out');
    end
    invalid_judge = 0;
    list = refine(guess, list, judge);
    if isempty(list)
        warning('음... 잘못한거 같은데? 자 처음부터 다시 해보자?')
        list = gen_all_nums();
        n_try = 0;
    end
end

end

%%

function hangul = num2hangul(num)
hanguls = ["한", "두", "세", "네", "다섯", "여섯", "일곱", "여덟", "아홉"];
hangul = hanguls(num);
end

function guess = gen_guess(list)
% 가능한 목록 중 랜덤으로 하나 고름
guess = list(randperm(size(list,1), 1),:);
end

%% 가능한 모든 세자리 숫자 목록 만들기 (012부터 987까지)

function list = gen_all_nums()

list = (12:987)';
list = num2str(list, '%03d');

% 중복되는 숫자가 있는 경우 삭제
i = 1;
while i <= size(list,1)
    if length(list(i, :)) ~= length(unique(list(i, :)))
        list(i,:) = [];
    else
        i = i+1;
    end
end

end

%%

function list = refine(guess, list, rule)
% list 중 rule에 맞는 것만 남기기
i = 1;
while i<=size(list, 1)
    if ~strcmp(judge_single(guess, list(i,:)), rule)
        list(i,:) = [];
    else
        i = i+1;
    end
end

end

%%

function judge = judge_single(guess, candi)
% candi가 답인데 guess를 넣으면 어떤 judge가 나오는가?

judge = "";
for i = 1:length(guess)
    if find(guess(i) == candi)
        if find(guess(i) == candi) == i
            judge = judge + 's';
        else
            judge = judge + 'b';
        end
    end
end
judge = char(judge.count("s") + "s" + judge.count("b") + "b");
if judge(3) == '0'
    judge(3:4) = [];
end
if judge(1) == '0'
    judge(1:2) = [];
end
if isempty(judge)
    judge = 'out';
end

end
