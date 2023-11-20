

%----------------------- Clear & Import Image --------------------------------%

clear 
clf 
IMG_Initial = imread("DB1/db1_01.jpg");

% Initial changes 


[height, width, ~] = size(IMG_Initial);

minDimension = min(height, width);
sizeSquare = minDimension / 1.3; 

% Calculate the region to crop [xmin, ymin, width, height]
cropRegion = [(width - sizeSquare) / 2, (height - sizeSquare) / 2, sizeSquare, sizeSquare];

% Crop the image
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
Mouth = IMG_Mouth_Map - IMG_Skin_Color; 

test = Eyes + Mouth; 

[mouthx, mouthy, leftEye, rightEye] = EyeCoordinates(Eyes, Mouth); 

%se = strel('disk', 1); 
%test = imopen(test, se);
%test = imclose(test, se);


%---------------------------- Plot The Images ----------------------------%

% Original Image

subplot(2, 3, 1);
imshow(IMG);
title('Original Image');

hold on;
scatter(mouthx,mouthy, 90, 'blue', 'filled');  
scatter(leftEye(:,1),leftEye(:,2), 110, 'magenta', 'filled');  
scatter(rightEye(:,1),rightEye(:,2), 70, 'blue', 'filled');  
title('Eye Coordinates');
xlabel('X-coordinate');
ylabel('Y-coordinate');
axis equal;
hold off; 

% Grey World Assumption
subplot(2, 3, 2);
imshow(IMG_Grey_World);
title('Color correction');

% Eye Map
subplot(2, 3, 3);
imshow(Eyes);
title('Eye Map');

% Skin Color Detection
subplot(2, 3, 4);
imshow(IMG_Skin_Color);
title('Skin Color Detection');

% Mouth map 
subplot(2,3,5) 
imshow(Mouth); 
title('Mouth map'); 

% Eye + Mouth final
subplot(2, 3, 6);
imshow(test);
title('Combined Eyes, Mouth and Face Mask');