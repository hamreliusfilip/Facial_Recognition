function [scaledImage] = Scale(Im)

% Calculate the initial distance between the eyes in the input image
initial_eye_distance = sqrt((x_eye2 - x_eye1)^2 + (y_eye2 - y_eye1)^2);

% Specify the desired distance between the eyes for the scaled images
desired_eye_distance = 150; % Set the desired distance as needed

% Calculate the scaling factor based on the desired and initial eye distances
scaling_factor = desired_eye_distance / initial_eye_distance;

% Resize the image based on the scaling factor
scaledImage = imresize(rotatedImage, scaling_factor);

% Display the scaled image
%imshow(scaledImage);

end