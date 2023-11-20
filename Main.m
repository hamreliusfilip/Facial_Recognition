

%----------------------- Clear & Import Image --------------------------------%

clear 
clf 
IMG = imread("DB1/db1_16.jpg");

%------------------------ Grey World Assumption  -----------------------------%

IMG_Grey_World = ColorCorrection(IMG);

%------------------------------- Eye Map  ------------------------------------%

IMG_Eye_Map = EyeMap(IMG_Grey_World);


%--------------------- Skin Color Dedection with HSV  ------------------------%

IMG_Skin_Color = SkinColorDedection(IMG_Grey_World); 
IMG_Skin_Color = ~IMG_Skin_Color;

%------------------------------- Mouth Mask  ---------------------------------%



%---------------------- Combine & Find the Eyes & Mouth  ---------------------%

Eyes = IMG_Eye_Map - IMG_Skin_Color; 

%---------------------------- Plot The Images ----------------------------%

% Original Image
subplot(2, 3, 1);
imshow(IMG);
title('Original Image');

hold on;
scatter(position(:, 1), position(:, 2), 50, 'r', 'filled');  % 'r' for red color, adjust marker size (50 in this case)
title('Eye Coordinates');
xlabel('X-coordinate');
ylabel('Y-coordinate');
axis equal;
hold off; 

% Grey World Assumption
subplot(2, 3, 2);
imshow(IMG_Grey_World);
title('Grey World Assumption');

% Eye Map
subplot(2, 3, 3);
imshow(IMG_Eye_Map);
title('Eye Map');

% Skin Color Detection
subplot(2, 3, 4);
imshow(IMG_Skin_Color);
title('Skin Color Detection');

% Eye final
subplot(2, 3, 6);
imshow(Eyes);
title('Combined Eyes and Face Mask');