function [croppedImage] = Face_Alignment_Normalization(IMG, leftEye, rightEye)

%------- Padding -------%
target_size = [450, 450];
 
% Calculate the amount of padding needed
rows = size(IMG, 1);
cols = size(IMG, 2);
pad_rows = max(0, target_size(1) - rows);
pad_cols = max(0, target_size(2) - cols);

% Pad the image
%padded_image = padarray(IMG, [pad_rows, pad_cols], 0, 'b');

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


% Display the resulting image with the eyes centered and along the x-axis
% imshow(rotatedImage);

%---------SCALE---------%

% Vill nu skala för att få samma avstånd mellan ögonen på alla bilder


% Specify the desired distance between the eyes for the scaled images
desired_eye_distance = 150; 

scale_factor = desired_eye_distance/diff_x;
scaledImage  = imresize(rotatedImage, scale_factor, 'bicubic');

% Calc midpoint
[height_scaled, width_scaled, ~] = size(scaledImage); % [pixel in x, pixel in y, rgb]
center_x = width_scaled/2;
center_y = height_scaled/2;

% Crop image
margin_x = 40;
margin_y = 40;
croppedImage = imcrop(scaledImage, [(center_x-margin_x) (center_y-margin_y) desired_eye_distance+2*margin_x desired_eye_distance+2*margin_y]);

end