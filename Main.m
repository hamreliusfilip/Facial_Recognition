%----------------------- Clear, Import & Crop --------------------------------%

clear 
clf 
IMG_Initial = imread("DB1/db1_16.jpg");

[height, width, ~] = size(IMG_Initial);

minDimension = min(height, width);
sizeSquare = minDimension / 1.3; 
cropRegion = [(width - sizeSquare) / 2, (height - sizeSquare) / 2, sizeSquare, sizeSquare];

IMG = imcrop(IMG_Initial, cropRegion);



%------------------------ Grey World Assumption  -----------------------------%

IMG_Grey_World = ColorCorrection(IMG); % Används ej

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



fixedImage = Translation(IMG,leftEye,rightEye); 

%---------------------- Combine & Find the Eyes & Mouth  ---------------------%

[height, width, ~] = size(fixedImage);

% Center of the image
mid_x = round(width / 2);
mid_y = round(height / 2);


figure
subplot(1, 2, 1);
imshow(fixedImage); 
hold on; 

scatter(mid_x,mid_y, 200, 'yellow', 'filled');  


hold off; 


subplot(1, 2, 2);
imshow(IMG);


hold on;
scatter(mouthx,mouthy, 150, 'blue', 'filled');  
scatter(leftEye(:,1),leftEye(:,2), 140, 'magenta', 'filled');  
scatter(rightEye(:,1),rightEye(:,2), 140, 'magenta', 'filled');  
xlabel('X-coordinate');
ylabel('Y-coordinate');
axis equal;
hold off



%---------------------------- Uncomment to see all steps ----------------------------%

% subplot(3, 3, 1);
% imshow(IMG);
% title('Original Image');
% 
% hold on;
% scatter(mouthx,mouthy, 150, 'blue', 'filled');  
% scatter(leftEye(:,1),leftEye(:,2), 140, 'magenta', 'filled');  
% scatter(rightEye(:,1),rightEye(:,2), 140, 'magenta', 'filled');  
% title('Eye Coordinates');
% xlabel('X-coordinate');
% ylabel('Y-coordinate');
% axis equal;
% hold off; 
% 
% subplot(3, 3, 2);
% imshow(IMG_Grey_World);
% title('Color correction');
% 
% subplot(3, 3, 3);
% imshow(Eyes);
% title('Eye Map');
% 
% subplot(3, 3, 4);
% imshow(IMG_Skin_Color);
% title('Skin Color Detection');
% 
% subplot(3,3,5) 
% imshow(Mouth); 
% title('Mouth map'); 
% 
% subplot(3, 3, 6);
% imshow(test);
% title('Combined Eyes, Mouth and Face Mask');