function [croppedImage] = Face_Alignment_Normalization(IMG, leftEye, rightEye)

%------ Move left eye to center ------%

% Get image dimensions
[height, width, ~] = size(IMG);

% Center of the image
mid_x = round(width / 2);
mid_y = round(height / 2);

% Translate the image to center it at the origin
delta_x = round(abs(mid_x - leftEye(1,1))); 
delta_y = round(abs(mid_y - leftEye(1,2)));

% Pad the image
padded_image = padarray(IMG, [200, 200], 0, 'both');

translatedImage = imtranslate(padded_image, [delta_x, delta_y]);

%---------ROTATE---------%
% Calculating the difference in x and y coordinates between the eyes
diff_x = abs(leftEye(1,1) - rightEye(1,1));
diff_y = abs(leftEye(1,2) - rightEye(1,2));

% Calculate the angle between the line connecting 
% the eyes and the horizontal axis (in degrees)
angle_between_eyes = atan2(diff_y, diff_x) * 180 / pi;


% if-statement handling if left or right eye is higher
if (leftEye(1,2) > rightEye(1,2))

    % Rotate the image to align the eyes horizontally
    rotatedImage = imrotate(translatedImage, -angle_between_eyes, 'bicubic', 'loose');

else 

    rotatedImage = imrotate(translatedImage, angle_between_eyes, 'bicubic', 'loose');

end

%---------SCALE---------%

% Set desired eye distance for scaled images
desired_eye_distance = 150; 

% Calculate scale factor
scale_factor = desired_eye_distance/diff_x;
scaledImage  = imresize(rotatedImage, scale_factor, 'bicubic');

% Calculate new center point 
[height_scaled, width_scaled, ~] = size(scaledImage);
centerX = width_scaled/2;
centerY = height_scaled/2;

% Crop the scaled image around the center
mX = 40;
mY = 40;

height = desired_eye_distance+2*mX;
width = desired_eye_distance+2*mY;

croppedImage = imcrop(scaledImage, [(centerX-mX) (centerY-mY) height width]);

end