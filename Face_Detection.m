
function [IMG_Grey_World,leftEye,rightEye] = Face_Detection(IMG_Initial) 

%----------------------- Clear, Import & Crop --------------------------------%

[height, width, ~] = size(IMG_Initial);

minDimension = min(height, width);
sizeSquare = minDimension / 1.3; 
cropRegion = [(width - sizeSquare) / 2, (height - sizeSquare) / 2, sizeSquare, sizeSquare];

IMG = imcrop(IMG_Initial, cropRegion);

%------------------------ Grey World Assumption  -----------------------------%

IMG_Grey_World = GrayWorld(IMG);

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

[leftEye, rightEye] = EyeCoordinates(test, Mouth);

end 
