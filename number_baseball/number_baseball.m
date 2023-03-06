ccc

num = input('세자리 숫자 입력(0으로 시작해도 ㄱㅊ): ', 's');

% 가능한 모든 세자리 숫자 목록
list = gen_all_nums();

invalid_judge = 0;
while true % 못 맞추는 동안
    if invalid_judge == 0
        guess = gen_guess(list);
    end
    fprintf('혹시... %s 이거? ', guess)
    judge = input('', 's');
    if strcmp(judge, '3s')
        disp('앗싸 맞췄다')
        break
    elseif ~ismember(judge, {'2s','1s2b','1s1b','1s','3b','2b','1b','out'})
        warning('제대로 다시 써라')
        invalid_guess = 1;
    end
    list = exclude(guess, list, judge);
    if isempty(list)
        warning('음... 잘못한거 같은데? 자 처음부터 다시 해보자?')
        list = gen_all_nums();
    end
end


%%
function guess = gen_guess(list)
guess = list(randperm(size(list,1), 1),:);
end

function list = gen_all_nums()
% 가능한 모든 세자리 숫자 목록
list = (12:987)';
list = num2str(list, '%03d');

% 중복되는 숫자가 있는 경우 삭제
i = 1;
while i <= size(list,1)
    if length(list(i, :)) ~= ...
            length(unique(list(i, :)))
        list(i,:) = [];
    else
        i = i+1;
    end
end

end


function list = exclude(guess, list, rule)
% list 중 rule에 안 맞는 것은 제거
i = 1;
while i<=size(list, 1)
    if ~strcmp(judge_single(guess, list(i,:)), rule)
        list(i,:) = [];
    else
        i = i+1;
    end
end

end


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
