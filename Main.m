

%----------------------- Clear & Import Image --------------------------------%

clear 
clf 
IMG_Initial = imread("DB1/db1_05.jpg");

% Initial changes 


[height, width, ~] = size(IMG_Initial);

minDimension = min(height, width);
sizeSquare = minDimension / 1.5; 

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

%---------------------- Combine & Find the Eyes & Mouth  ---------------------%

Eyes = IMG_Eye_Map - IMG_Skin_Color; 
Mouth = IMG_Mouth_Map - IMG_Skin_Color; 

test = Eyes + Mouth; 

[leftEye,rightEye] = EyeCoordinates(Eyes, Mouth); 


%---------------------------- Plot The Images ----------------------------%

% Original Image
subplot(2, 3, 1);
imshow(IMG);
title('Original Image');

hold on;
scatter(leftEye(:, 1), leftEye(:, 2), 50, 'r', 'filled');  
scatter(rightEye(:, 1), rightEye(:, 2), 50, 'magenta', 'filled'); 
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
imshow(IMG_Eye_Map);
title('Eye Map');

% Skin Color Detection
subplot(2, 3, 4);
imshow(IMG_Skin_Color);
title('Skin Color Detection');

% Mouth map 
subplot(2,3,5) 
imshow(IMG_Mouth_Map); 
title('Mouth map'); 

% Eye + Mouth final
subplot(2, 3, 6);
imshow(test);
title('Combined Eyes, Mouth and Face Mask');