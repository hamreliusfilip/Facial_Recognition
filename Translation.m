function [croppedImage] = Translation(IMG, leftEye, rightEye)

%------- Padding -------% % Tror ej vi behöver?
% Set the target size
% target_size = [650, 650];
% 
% % Calculate the amount of padding needed
% rows = size(IMG, 1);
% cols = size(IMG, 2);
% pad_rows = max(0, target_size(1) - rows);
% pad_cols = max(0, target_size(2) - cols);
% 
% % Pad the image
% padded_image = padarray(IMG, [pad_rows, pad_cols], 0, 'post');


%------ Move left eye to center ------%

% Get image dimensions
[height, width, ~] = size(IMG);

% Center of the image
mid_x = round(width / 2);
mid_y = round(height / 2);

% Translate the image to center it at the origin
delta_x = mid_x - leftEye(1); 
delta_y = mid_y - leftEye(2);

% Pad the image
padded_image = padarray(IMG, [delta_x, delta_y], 0, 'both');
translatedImage = imtranslate(padded_image, [delta_x, delta_y]);


%---------ROTATE---------%
% Calculating the difference in x and y coordinates between the eyes
diff_x = abs(rightEye(1) - leftEye(1));
diff_y = abs(rightEye(2) - leftEye(2));

% Calculate the angle between the line connecting 
% the eyes and the horizontal axis (in degrees)
angle_between_eyes = atan2(diff_y, diff_x) * 180 / pi;


% if-statement handling if left or right eye is higher
if (left_eye(2) > right_eye(2))

    % Rotate the image to align the eyes horizontally
    rotatedImage = imrotate(translatedImage, -angle_between_eyes, 'bicubic');

else 

    rotatedImage = imrotate(translatedImage, angle_between_eyes, 'bicubic');

end

% Display the resulting image with the eyes centered and along the x-axis
%imshow(rotatedImage);


%---------SCALE---------%

% Vill nu skala för att få samma avstånd mellan ögonen på alla bilder


% Anger önskat avstånd mellan ögonen för de skalade bilderna
desired_eye_distance = 120; 

% Scale rotated image if dist is not equal 0
if diff_x ~= 0
    scale_factor = desired_eye_distance/diff_x;
    scaledImage  = imresize(rotatedImage, scale_factor);
end

% Beräknar ny mittpunkt 
[height_scaled, width_scaled, ~] = size(scaledImage); % [pixel in x, pixel in y, rgb]
center_x = width_scaled/2;
center_y = height_scaled/2;

% Croppar bilden
margin_x = 40;
croppedImage = imcrop(scale_img, [(center_x-margin_x) (center_y-60) eye_dist+2*margin_x 230]);

% Visa den skalade bilden
%imshow(croppedImage);

end