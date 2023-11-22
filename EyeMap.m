function [output_image]=EyeMap(Im)

imgChrome = rgb2ycbcr(Im);

Y = uint16(255 * mat2gray(imgChrome(:,:,1)));
Cb = uint16(255 * mat2gray(imgChrome(:,:,2)));
Cr = uint16(255 * mat2gray(imgChrome(:,:,3)));

Cr_neg = 255 - Cr;

EyeMapC = (1/3).*(Cb.^2 + Cr_neg.^2 + (Cb./Cr));
EyeMapC = im2double(EyeMapC);

se = strel('disk', 1);
EyeMapL = imdilate(Y, se) ./ (imerode(Y, se) + 1);
EyeMapL = im2double(histeq(EyeMapL));

EyeMap = EyeMapL.*EyeMapC;
EyeMap = histeq(EyeMap);

output_image = EyeMap > 0.85;

output_image = im2double(output_image);

output_image = imclearborder(output_image);

output_image = histeq(output_image);

return