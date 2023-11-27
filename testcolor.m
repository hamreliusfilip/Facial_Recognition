
img = imread("DB2/il_01.jpg");



correctedImg = GrayWorld(img);

%imshow(img)
%subplot(1, 2, 1)

%imshow(colorcorrectedImage);
%subplot(1, 2, 2)

% Display the original and corrected images side by side
figure;
subplot(1, 2, 1);
imshow(img);
title('Original Image');

subplot(1, 2, 2);
imshow(correctedImg);
title('Corrected Image');