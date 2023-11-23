%----------------------- Clear, Import & Crop --------------------------------%

clear 
clf 
IMG_Initial = imread("DB1/db1_01.jpg");

[height, width, ~] = size(IMG_Initial);

minDimension = min(height, width);
sizeSquare = minDimension / 1.3; 
cropRegion = [(width - sizeSquare) / 2, (height - sizeSquare) / 2, sizeSquare, sizeSquare];

IMG = imcrop(IMG_Initial, cropRegion);


%------------------------ Grey World Assumption  -----------------------------%

IMG_Grey_World = ColorCorrection(IMG);

%------------------------------- Eye Map  ------------------------------------%

IMG_Eye_Map = EyeMap(IMG_Grey_World);

%--------------------- Skin Color Dedection with HSV  ------------------------%

IMG_Skin_Color = SkinColorDedection(IMG_Grey_World); 
IMG_Skin_Color = ~IMG_Skin_Color;

%------------------------------- Mouth Mask  ---------------------------------%

IMG_Mouth_Map = MouthMap(IMG_Grey_World);

se = strel('disk',5); 
IMG_Mouth_Map = imopen(IMG_Mouth_Map, se);
IMG_Mouth_Map = imclose(IMG_Mouth_Map, se);


%---------------------- Combine & Find the Eyes & Mouth  ---------------------%

Eyes = IMG_Eye_Map - IMG_Skin_Color; 
Mouth = IMG_Mouth_Map; 

test = Eyes + Mouth; 

[mouthx, mouthy, leftEye, rightEye] = EyeCoordinates(test, Mouth); 

%---------------------- Combine & Find the Eyes & Mouth  ---------------------%

imshow(IMG);

hold on;
scatter(mouthx,mouthy, 150, 'blue', 'filled');  
scatter(leftEye(:,1),leftEye(:,2), 140, 'magenta', 'filled');  
scatter(rightEye(:,1),rightEye(:,2), 140, 'magenta', 'filled');  
xlabel('X-coordinate');
ylabel('Y-coordinate');
axis equal;
hold off; 






























%---------------------------- Uncomment to see all steps ----------------------------%

%subplot(2, 3, 1);
%imshow(IMG);
%title('Original Image');

%hold on;
%scatter(mouthx,mouthy, 150, 'blue', 'filled');  
%scatter(leftEye(:,1),leftEye(:,2), 140, 'magenta', 'filled');  
%scatter(rightEye(:,1),rightEye(:,2), 140, 'magenta', 'filled');  
%title('Eye Coordinates');
%xlabel('X-coordinate');
%ylabel('Y-coordinate');
%axis equal;
%hold off; 

%subplot(2, 3, 2);
%imshow(IMG_Grey_World);
%title('Color correction');

%subplot(2, 3, 3);
%imshow(Eyes);
%title('Eye Map');

%subplot(2, 3, 4);
%imshow(IMG_Skin_Color);
%title('Skin Color Detection');

%subplot(2,3,5) 
%imshow(Mouth); 
%title('Mouth map'); 

%subplot(2, 3, 6);
%imshow(test);
%title('Combined Eyes, Mouth and Face Mask');