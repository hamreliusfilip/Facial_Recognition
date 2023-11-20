function [scaledImage] = Scale(Im)

% Beräkna initialt avstånd mellan ögonen i den inlästa bilden
initial_eye_distance = sqrt((x_eye2 - x_eye1)^2 + (y_eye2 - y_eye1)^2);

% Ange önskat avstånd mellan ögonen för de skalade bilderna
desired_eye_distance = 150; % Ange det avstånd du vill ha

% Beräkna skalningsfaktorn baserat på det önskade avståndet och det initiala avståndet
scaling_factor = desired_eye_distance / initial_eye_distance;

% Skala om bilden baserat på skalningsfaktorn
scaledImage = imresize(rotatedImage, scaling_factor);

% Visa den skalade bilden
imshow(scaledImage);

end