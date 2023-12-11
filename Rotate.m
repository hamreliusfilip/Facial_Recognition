function [rotatedImage] = Rotate(Im) 

% Calculate the difference in x and y coordinates between the eyes
dx = x_eye2 - x_eye1;
dy = y_eye2 - y_eye1;

% Calculate the angle between the line connecting 
% the eyes and the horizontal axis (in degrees)
angle_between_eyes = atan2(dy, dx) * 180 / pi;

% Rotate the image to align the eyes horizontally
rotatedImage = imrotate(translatedImage, angle_between_eyes, 'bicubic', 'crop');

% Display the resulting image with the eyes centered and along the x-axis
%imshow(rotatedImage);

end
