
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
%imshow(IMG_Initial)
 
[IMG,leftEye,rightEye] = Face_Detection(IMG_load);
 
img = Face_Alignment_Normalization(IMG,leftEye,rightEye); 

% subplot(1,2,1)
% imshow(IMG) 
% hold on
% scatter(leftEye(:,1),leftEye(:,2), 'SizeData', 120, 'Marker', 'o', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b'); 
% scatter(rightEye(:,1), rightEye(:,2), 'SizeData', 120, 'Marker', 'o', 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
% 
% subplot(1,2,2) 
% imshow(img) 
    
test = TestEigen(img);
disp(test)

% Alla värden uppdaterade: tis; 09:48 -> totalt 86%

%Vanligt 
% Alla fungerar 

%ROTATE 5
% 14 -> 15

%ROTATE -5
% Alla fungerar 

%TRANSLATE [30,0]
% Alla fungerar

%TRANSLATE [0,30]
% 2, 5, 7, 9, 10, 12, 15, 16 fungerar

%SCALING +10%
% 7 -> 4 (fel ögon) 

%SCALING -10%
% 7 -> 11 

%Tone 10%
% 1, 3, 6, 8, 9, 10, 11, 12, 13 fungerar

%Tone -30%
% Alla fungerar
