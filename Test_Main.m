
% % clear 
     
IMG_load = imread("DB1/db1_04.jpg");

%IMG_Initial = imrotate(IMG_load, 5,'bilinear','crop');
IMG_Initial = imrotate(IMG_load, -5,'bilinear','crop');
%IMG_Initial = imtranslate(IMG_load, [30,0]);
%IMG_Initial = imtranslate(IMG_load, [0,30]);
%IMG_Initial = imresize(IMG_load, 1.1);
%IMG_Initial = imresize(IMG_load, 0.9);
%IMG_Initial = IMG_load.*1.3;
%IMG_Initial = IMG_load.*0.7;
 
[IMG,leftEye,rightEye] = Face_Detection(IMG_Initial);
 
img = Face_Alignment_Normalization(IMG,leftEye,rightEye); 

imshow(IMG) 
hold on
scatter(leftEye(:,1),leftEye(:,2), 'r', 'filled');  % Reverse indices due to row-column ordering
scatter(rightEye(:,1), rightEye(:,2), 'b', 'filled');

figure
hold off
imshow(img)

    
test = TestEigen(img);
disp(test)

%ROTATE 5
% 6 -> 4 ögonen korrekta
% 13 -> 1 ögonen korrekta

%ROTATE -5
% 4 -> höger öga

%TRANSLATE [30,0]
% 13 -> 1 dock konstigt eftersom ögonen blir korrekta

%TRANSLATE [0,30]
% 3 -> 2 ögonen blir dock korrekta
% 4 -> 6
% 6 -> 5
% 8 -> 10

%SCALING +10%
% 6 -> 4 ögonen korrekta
% 7 -> 4 höger fel
% 13 -> 7

%SCALING -10%
% 2 -> 1 höger blir helt nära vänster
% 4 -> 6 höger helt off
% 6 -> 4 ögonen korrekt thooo
% 10 -> 13 höger öga helt off

%Tone 30%
% Alla fel utom 10an

%Tone -30%
% Alla fel
