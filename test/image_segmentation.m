% 설명: 이미지를 픽셀 수준에서 랜덤하게 절반으로 나누는 코드
% 예시 이미지는 image_segmentation.png를 확인

clear; 
clc;

src_image = ones(10, 10);

rng(42) % seed

len = numel(src_image);
randomind = randperm(numel(src_image), numel(src_image)/2);

% disp(length(randomind))

des_image_01 = src_image;
des_image_01(randomind) = 0;
des_image_02 = des_image_01;

for i = 1 : len
    if (des_image_01(i) == 0) 
        des_image_01(i) = src_image(i); 
    elseif (des_image_01(i) ~= 0) 
        des_image_01(i) = 0; 
    end
end

subplot(1, 2, 1); 
imshow(des_image_01); 
subplot(1, 2, 2); 
imshow(des_image_02)
