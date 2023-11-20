function [translatedImage] = Translation(Im)

% Use ginput to interactively select points
[x, y] = ginput(2);

% Extract the positions of the left and right eyes
x_eye1 = x(1);
y_eye1 = y(1);
x_eye2 = x(2);
y_eye2 = y(2);

% Display the selected points on the image
hold on;
plot(x_eye1, y_eye1, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
plot(x_eye2, y_eye2, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
hold off;


%%% Padding %%% 
% Set the target size
target_size = [650, 650];

% Calculate the amount of padding needed
rows = size(normalized_image, 1);
cols = size(normalized_image, 2);
pad_rows = max(0, target_size(1) - rows);
pad_cols = max(0, target_size(2) - cols);

% Pad the image
padded_image = padarray(normalized_image, [pad_rows, pad_cols], 0, 'post');

% Display the original and padded images
figure;
subplot(1, 2, 1);
imshow(normalized_image);
title('Original Image');

subplot(1, 2, 2);
imshow(padded_image);
title('Padded Image');

%%% Move left eye to center %%%

% Get image dimensions
[height, width, ~] = size(padded_image);

% Center of the image
mid_x = round(width / 2);
mid_y = round(height / 2);

% Translate the image to center it at the origin
delta_x = mid_x - x_eye1; 
delta_y = mid_y - y_eye1;
translatedImage = imtranslate(padded_image, [delta_x, delta_y]);

end