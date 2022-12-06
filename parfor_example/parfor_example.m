test = zeros(1, 2);
n = size(test, 1);

parfor idx = 1:5
    for i = 1:2
        disp(i);
    end

    j = 1;
    test_for = zeros(1, 2);
    for k = 1:n
        test_for(j) = 1;
        j = j + 1;
    end
    test = test_for;
end