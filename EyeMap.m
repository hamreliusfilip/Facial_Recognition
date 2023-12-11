function [output_image]=EyeMap(Im)

% Convert color space and extract channels
imgChrome = rgb2ycbcr(Im);
Y = uint16(255 * mat2gray(imgChrome(:,:,1)));
Cb = uint16(255 * mat2gray(imgChrome(:,:,2)));
Cr = uint16(255 * mat2gray(imgChrome(:,:,3)));

% Equation
Cr_neg = 255 - Cr;
EyeMapC = (1/3).*(Cb.^2 + Cr_neg.^2 + (Cb./Cr));
EyeMapC = im2double(EyeMapC);

% Morphological operations
se = strel('disk', 1);
EyeMapL = imdilate(Y, se) ./ (imerode(Y, se) + 1);
EyeMapL = im2double(histeq(EyeMapL));

% Compine EyeMapL and EyeMapC
EyeMap = EyeMapL.*EyeMapC;

% Histeq equalization
EyeMap = histeq(EyeMap);

% Binaray image output
output_image = EyeMap > 0.85;
output_image = im2double(output_image);

% Remove objects touching the border of image
output_image = imclearborder(output_image);

% Output
output_image = histeq(output_image);

return