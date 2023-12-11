function [output_image]=SkinColorDetection(Im)

    % Height and Width of input Im
    height = size(Im, 1);
    width = size(Im, 2);
    binaryIm = zeros(height, width);

    % Convert color space adn extract
    YCbCr = rgb2ycbcr(Im);
    Cb = YCbCr(:,:,2);
    Cr = YCbCr(:,:,3);
    
    % Find specifici values in range, try and error numbers
    [rowIndices, colIndices] = find(Cb >= 77 & Cb <= 200 & Cr >= 134 & Cr <= 173);
    numIndices = size(rowIndices, 1);

    % Set binaryIm values with corresponding pixels to 1
    for i = 1:numIndices
        binaryIm(rowIndices(i), colIndices(i)) = 1;
    end

    % Morphological operations
    se = strel('disk', 8, 4);
    openedImage = imopen(binaryIm, se);
    mask = imclose(openedImage, se);

    % Apply mask to og img
    rgbFaceMaskedImage = Im .* uint8(mask);
    resIm = im2double(rgbFaceMaskedImage);
    
%     resIm = rgbFaceMaskedImage;
%     resIm = im2double(resIm);

    % Convert to grayscale and binarize to get output_image
    grayResIm = rgb2gray(resIm);
    output_image = imbinarize(grayResIm);

   
return; 