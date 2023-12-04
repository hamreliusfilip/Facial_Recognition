
% % clear 
     
IMG_load = imread("DB1/db1_16.jpg");

%IMG_Initial = imrotate(IMG_load, 5,'bilinear','crop');
%IMG_Initial = imrotate(IMG_load, -5,'bilinear','crop');
%IMG_Initial = imtranslate(IMG_load, [30,0]);
%IMG_Initial = imtranslate(IMG_load, [0,30]);
%IMG_Initial = imresize(IMG_load, 1.1);
%IMG_Initial = imresize(IMG_load, 0.9);
%IMG_Initial = IMG_load.*1.1;
%IMG_Initial = IMG_load.*0.7;
 
[IMG,leftEye,rightEye] = Face_Detection(IMG_Initial);
 
img = Face_Alignment_Normalization(IMG,leftEye,rightEye); 

subplot(1,2,1)
imshow(IMG) 
hold on
scatter(leftEye(:,1),leftEye(:,2), 'SizeData', 120, 'Marker', 'o', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b'); 
scatter(rightEye(:,1), rightEye(:,2), 'SizeData', 120, 'Marker', 'o', 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');

subplot(1,2,2) 
imshow(img) 
    
test = TestEigen(img);
disp(test)

%Vanligt 
% Alla fungerar 

%ROTATE 5
% Alla fungerar

%ROTATE -5
% Alla fungerar 

%TRANSLATE [30,0]
% Alla fungerar

%TRANSLATE [0,30]
% 3 -> 2
% 4 -> 13
% 6 -> 1
% 8 -> 10
% 11 -> 1
% 13 -> 1
% 14 -> 2

%SCALING +10%
% 7 -> 4 (fel ögon) 
% 12 -> error 

%SCALING -10%
% 4 -> error 

%Tone 30%
% Alla fel utom 10an

%Tone -30%
% Alla fel
